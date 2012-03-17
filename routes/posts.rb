class MyApp < Sinatra::Base

  get '/posts' do
    @posts = Post.all(sort: [[ :created_at, :desc ]])
    slim :post_index
  end

  post '/posts' do
    user = session['user'].merge({:uid=>session[:uid]})
    @post = Post.create(:body=>params["post"], :user=>user)
    redirect '/posts'
  end

end
