require "bundler/setup"
Bundler.require(:default)

if ENV["REDISTOGO_URL"] then
  uri = URI.parse(ENV["REDISTOGO_URL"])
  Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
end

module Eat
    @queue = :food

    def self.perform(food)
      puts "Ate #{food}!"
    end
end

class Application < Sinatra::Base

  get '/' do
      "<a href='/eat/mango'>eat something</a>
       <a href='/resque'>resque</a>"
  end

  get '/eat/:food' do
      Resque.enqueue(Eat, params['food'])
      "Put #{params['food']} in fridge to eat later."
  end

end