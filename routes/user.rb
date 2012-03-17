class MyApp < Sinatra::Base
  before do
    @flash = session.delete(:flash)

    # checking if logged in
    if request.path_info != '/auth/facebook/callback' 
     redirect '/auth/facebook' unless session[:uid]
    end
  end

  get '/auth/facebook/callback' do
    session[:uid] = request.env['omniauth.auth']["uid"]
    session[:user] = request.env['omniauth.auth']['info']
    redirect '/'
  end

  get "/logout" do
    session.delete(:uid)
    session.delete(:user)
    "Successfuly Logged out"
  end

end
