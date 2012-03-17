class MyApp < Sinatra::Base

  get '/posts' do
    puts session[:uid]
    haml :post_index
  end

end
