web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
resque: env TERM_CHILD=1 VVERBOSE=1 bundle exec rake jobs:work
resque: env TERM_CHILD=1 VVERBOSE=1 RESQUE_TERM_TIMEOUT=10 QUEUE=* bundle exec rake resque:work
