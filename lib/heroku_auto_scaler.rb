require 'heroku-api'

module HerokuAutoScaler
  module AutoScaling
    def after_perform_scale_down(*args)
      HerokuAutoScaler.scale_down!
    end

    def after_enqueue_scale_up(*args)
      HerokuAutoScaler.scale_up!
    end

    def on_failure(e, *args)
      Rails.logger.info("Resque Exception for [#{self.to_s}, #{args.join(', ')}] : #{e.to_s}")
      HerokuAutoScaler.scale_down!
    end
  end

  extend self

  attr_accessor :ignore_scaling

  def clear_resque
    Resque::Worker.all.each {|w| w.unregister_worker}
  end

  def configure(&block)
    instance_eval(&block) if block_given?
  end

  def scale_by(&block)
    self.scaling_block = block
  end

  def scale_down!(&block)
    Rails.logger.info "Scale down j:#{job_count} w:#{resque_workers}"
    sleep(10)
    self.heroku_workers = 0 if job_count == 0 && resque_workers == 1 
  end

  def scale_up!(&block)
    return if ignore_scaling
    pending = job_count
    self.heroku_workers = workers_for(pending) if pending > 0
    Rails.logger.info "Scale up j:#{pending} w:#{resque_workers}"
  end

  private

  attr_accessor :scaling_block

  def heroku
    if ENV['HEROKU_USER'] && ENV['HEROKU_PASSWORD'] && ENV['HEROKU_APP']
      @heroku ||= Heroku::API.new(username: ENV['HEROKU_USER'], password: ENV['HEROKU_PASSWORD'])
    else
      false
    end
  end

  def heroku_workers=(qty)
    heroku.post_ps_scale(ENV['HEROKU_APP'], "worker", qty) if heroku
  end

  def job_count
    Resque.info[:pending] + Resque.info[:working]
  end

  def resque_workers
    Resque.info[:workers]
  end

  def workers_for(pending_jobs)
    if scaling_block
      scaling_block.call(pending_jobs)
    else
      [
        { workers: 1, job_count: 1 },
        { workers: 2, job_count: 15 },
        { workers: 3, job_count: 25 }
      ].reverse_each do |scale_info|
        # Run backwards so it gets set to the highest value first
        if pending_jobs >= scale_info[:job_count]
          return scale_info[:workers]
        end
      end
    end
  end
end
