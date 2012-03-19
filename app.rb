require "bundler/setup"
require "./models/Tweet"
Bundler.require(:default)

if ENV["REDISTOGO_URL"] then
  uri = URI.parse(ENV["REDISTOGO_URL"])
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

Mongoid.configure do |config|
  if ENV['MONGOHQ_URL']
    conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
    uri = URI.parse(ENV['MONGOHQ_URL'])
    config.master = conn.db(uri.path.gsub(/^\//, ''))
  else
    config.master = Mongo::Connection.from_uri("mongodb://localhost:27017").db('test')
  end
end

class Application < Sinatra::Base

  get '/' do
    ""
  end
  
  get '/nou_tweet' do
    @tweet = Tweet.new(:screen_name=>"arolet",:lat=>1.2238293829382,:lon=>10.2238293829382,:time=>'03/04/2012 21:43:45',:num_retweets=>25, :status=>"Si no lo veo no lo creo")
    @tweet.save
    "Tweet saved"
    # slim :nou_tweet
  end

end

class Eat
    @queue = :food

    def self.perform(food)
      @tweet = Tweet.new(:screen_name=>"arolet",:lat=>1.2238293829382,:lon=>10.2238293829382,:time=>'03/04/2012 21:43:45',:num_retweets=>25, :status=>"Si no lo veo no lo creo")
      @tweet.save
      
      puts "Tweet saved"
    end
end