class MyApp < Sinatra::Base

  get '/posts' do
    puts session[:uid]
    slim :post_index
  end

end
