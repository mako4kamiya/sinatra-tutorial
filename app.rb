require 'sinatra'
require 'sinatra/reloader'

set :public_folder, 'public'

get '/' do
    "hello world"
end

get '/ruby' do
    "hello ruby"
end

get '/hello' do #/hello?name=mako
    @name = params[:name]
    erb :hello
  end

  get '/user/:user_name' do #user/mako
    user_name = params[:user_name]
      "<h1>Hello #{user_name}!</h1>"
    end

get '/time' do
    Time.now.to_s
end