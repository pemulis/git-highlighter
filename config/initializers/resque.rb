Resque.redis = REDIS_WORKER
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }
