require 'rubygems'
require 'resque'
require './app.rb'

# if ENV["REDISTOGO_URL"] then
#   uri = URI.parse(ENV["REDISTOGO_URL"])
#   Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
# else
#   Resque.redis = Redis.new(:host => "localhost", :port => 6379)
# end

# require './jobs'
# require 'system_timer'    

handler { |job|
  Resque.enqueue(job, 'mango')
}

every 1.seconds, Eat
