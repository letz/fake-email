require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'sinatra/cross_origin'
require 'json'
require './models/email'

configure do
  enable :cross_origin
end

options '*' do
  response.headers['Allow'] = 'HEAD,GET,PUT,POST,DELETE,OPTIONS'
  response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
  200
end

get '/' do
  send_file 'views/root.html'
end

get '/check' do
  content_type :json

  if params[:email].nil?
    { error: 'email parameter is required' }.to_json
  elsif Email.valid?(params[:email])
    {
      email: params[:email],
      fake: Email.exists?(domain: Email.parse_domain(params[:email]))
    }.to_json
  else
    { error: 'invalid email', email: params[:email] }.to_json
  end
end
