class MyApp < Sinatra::Base

  get '/posts' do
    haml :post_index
  end

end
