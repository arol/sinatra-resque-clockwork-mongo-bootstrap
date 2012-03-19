web: bundle exec thin start -p $PORT
resque-web: bundle exec resque-web --foreground
resque: bundle exec rake jobs:work
clock: bundle exec clockwork ./clock.rb
