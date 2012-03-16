require 'sinatra/base'
require_relative 'routes/init'
require_relative 'helpers/init'
require_relative 'models/init'

require 'mongoid'

class MyApp < Sinatra::Base
  enable :method_override
  enable :sessions
  set :session_secret, 'super secret'

  Mongoid.configure do |config|
    if ENV['MONGOHQ_URL']
      conn = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
      uri = URI.parse(ENV['MONGOLAB_URI'])
      config.master = conn.db(uri.path.gsub(/^\//, ''))
    else
      config.master = Mongo::Connection.from_uri("mongodb://localhost:27017").db('bcc-community-test')
    end
  end

  configure do
    set :app_file, __FILE__
  end

  configure :development do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :qa do
    enable :logging, :dump_errors, :raise_errors
  end

  configure :production do
    set :raise_errors, false #false will show nicer error page
    set :show_exceptions, false #true will ignore raise_errors and display backtrace in browser
  end
end
