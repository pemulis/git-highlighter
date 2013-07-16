Resque.redis = REDIS_WORKER
Resque::Plugins::Status::Hash.expire_in = (15)
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }
