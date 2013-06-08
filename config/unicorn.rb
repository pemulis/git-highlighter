# Unicorn Server Config

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 30 
preload_app true

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
    Rails.logger.info('Disconnected from ActiveRecord')
  end

  if defined?(Resque)
    Resque.redis.quit
    Rails.logger.info('Disconnected from Redis')
  end
end 

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
    Rails.logger.info('Connected to ActiveRecord')
  end

  if defined?(Resque)
    Resque.redis = REDIS_WORKER 
    Rails.logger.info('Connected to Redis')
  end
end
