require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'sinatra/activerecord'
require 'json'

class Email < ActiveRecord::Base
end

get '/' do
  %Q{
    <h1> Fake Emails</h1>
    <h4> Usage Example: </h4>
    <a target='_blank' href='/check?email=email@domain.com'> #{request.host}/check?email=email@domain.com</a>

    <h4> Contribute: </h4>
    <p> <a href='https://github.com/wesbos/burner-email-providers' target='_blank'> https://github.com/wesbos/burner-email-providers</a> for the email list.<p>
    <p> <a href='https://github.com/letz/fake-email' target='_blank'> https://github.com/letz/fake-email</a> for the server.<p>
  }
end

get '/check' do
  content_type :json

  split_email = params[:email].split('@')
  if split_email.size != 2
    { error: 'invalid email', email: params[:email] }.to_json
  else
    {
      email: params[:email],
      fake: Email.exists?(domain: split_email.last)
    }.to_json
  end
end
