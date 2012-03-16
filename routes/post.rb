class MyApp < Sinatra::Base
  before do
    @flash = session.delete(:flash)
  end

  get '/posts' do
    haml :post_index
  end

end
