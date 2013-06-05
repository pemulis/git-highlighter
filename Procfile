web: bundle exec unicorn -p $PORT -c ./config/unicorn.rb
resque: env TERM_CHILD=1 VVERBOSE=1 rake jobs:work
resque: env TERM_CHILD=1 VVERBOSE=1 RESQUE_TERM_TIMEOUT=10 QUEUE=* rake resque:work
