require 'sinatra'
require 'sinatra/reloader'
#画像フォルダを
require 'fileutils'



set :public_folder, 'public'

get '/' do
  erb :index
end

get '/ruby' do
  "hello ruby"
end

get '/hello' do #/hello?name=mako
  @name = params[:name]
  erb :hello
end

get '/user/:user_name' do #user/mako
  @user_name = params[:user_name]
  erb :user
end

get '/time' do
  erb :time
end

get '/form' do
  erb :form
end

post '/form_output' do
  # postのリクエストボディから値を取得
  @name = params[:name]
  @email = params[:email]
  @content = params[:content]
  
  # ファイルに保存する
  File.open("form.txt", mode = "a"){|f|
  f.write("#{@name},#{@email},#{@content}\n")
}
erb :form_output
end


get '/upload' do
  @images = Dir.glob("./public/images/*").map{|path| path.split('/').last }
  erb :upload #アップロードする画面
end

post '/upload' do
  @file_name = params[:img][:filename]
  FileUtils.mv(params[:img][:tempfile], "./public/images/#{@file_name}")
  # erb :uploaded
  redirect '/upload'
end