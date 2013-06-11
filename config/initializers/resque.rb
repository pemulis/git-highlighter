Resque.redis = REDIS_WORKER
Resque::Plugins::Status::Hash.expire_in = (24 * 60 * 60)
Dir["#{Rails.root}/app/jobs/*.rb"].each { |file| require file }
