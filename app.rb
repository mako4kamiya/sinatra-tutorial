###
#ライブラリの読み込み
##
require 'sinatra'
require 'sinatra/reloader'
require 'fileutils' #画像フォルダを扱います。
require 'sinatra/cookies' #クッキーを使います。
require 'pg' #PostgeSQLを使えるようにする。

###
#sinatraの設定
##
set :public_folder, 'public'
enable :sessions #セッションを使います


###
#DBの設定？
##
def db
  host = 'localhost'
  user = 'kamiyamasako' #自分のユーザー名を入れる
  password = ''
  dbname = 'myapp'

  # PostgreSQL クライアントのインスタンスを生成
  PG::connect(
  :host => host,
  :user => user,
  :password => password,
  :dbname => dbname)
end


###
#ルーティン
##
get '/' do
  erb :index
end

get '/ruby' do
  "hello ruby"
end

get '/hello' do
  # query string から取得
  # @name = params[:name]
  session[:name] =  params[:name]

  erb :hello
end

get '/user' do
  @users = db.exec_params("select * from users").to_a #データベースからusersのテーブルの中身を取ってくる
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