class MyApp < Sinatra::Base
  require 'awesome_print'

  get '/posts' do
    ap session
    haml :post_index
  end

end
