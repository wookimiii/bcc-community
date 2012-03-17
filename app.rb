require 'sinatra/base'
require 'omniauth-facebook'


require_relative 'routes/init'
require_relative 'helpers/init'
require_relative 'models/init'

require 'mongoid'

SCOPE = 'email,read_stream'

class MyApp < Sinatra::Base
  enable :method_override
  enable :sessions

  # turn off sinatra default X-Frame-Options for FB canvas
  set :protection, :except => :frame_options

  Mongoid.configure do |config|
    if ENV['MONGOLAB_URI']
      conn = Mongo::Connection.from_uri(ENV['MONGOLAB_URI'])
      uri = URI.parse(ENV['MONGOLAB_URI'])
      config.master = conn.db(uri.path.gsub(/^\//, ''))
    else
      config.master = Mongo::Connection.from_uri("mongodb://localhost:27017").db('bcc-community-test')
    end
  end
  
  use OmniAuth::Builder do 
    provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'], :scope => SCOPE
  end


  configure do
    set :app_file, __FILE__
  end

  configure :development do
    enable :logging, :dump_errors, :raise_errors

  end

  configure :production do
    set :raise_errors, false #false will show nicer error page
    set :show_exceptions, false #true will ignore raise_errors and display backtrace in browser
  end

  get '/' do
    redirect '/posts'
  end
end
