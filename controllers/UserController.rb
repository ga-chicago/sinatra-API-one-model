class UserController < ApplicationController


  before do
    payload_body = request.body.read
    @payload = JSON.parse(payload_body).symbolize_keys

    puts "-----------------------------------------------HERE IS OUR PAYLOAD"
    pp @payload
    puts "-----------------------------------------------------------------"

  end


  post '/login' do
    username = @payload[:username]
    password = @payload[:password]

    user = User.find_by(username: username)
    if user && user.authenticate(password)
      session[:logged_in] = true
      session[:username] = username
      session[:user_id] = user.id

      'you logged in dawg'
    else
      @message = "Login Unsuccessful"
      'wow man'
    end
  end


  post '/register' do
    user = User.new

    user.username = @payload[:username]
    user.password = @payload[:password]
    user.save
    session[:logged_in] = true
    session[:username] = user.username

    {
      success: true,
      message: "You are logged in",
      logged_in: true
    }.to_json

  end


end
