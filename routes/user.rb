class MyApp < Sinatra::Base
  before do
    @flash = session.delete(:flash)

    # checking if logged in
    if request.path_info != '/auth/facebook/callback' 
     redirect '/auth/facebook' unless session[:uid]
    end
  end

  post '/auth/facebook/callback' do
    session[:uid] = request.env['omniauth.auth']["uid"]
    redirect '/'
  end

  get "/logout" do
    session.delete(:uid)
  end

end
