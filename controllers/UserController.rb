class UserController < ApplicationController

  before do 
    payload_body = request.body.read
    @payload = JSON.parse(payload_body).symbolize_keys

  end


  post '/login' do

    puts ""
    puts "hitting login"
    puts "" 

    username = @payload[:username]
    password = @payload[:password]

    user = User.find_by(username: username)

    if user && user.authenticate(password)
      session[:logged_in] = true
      session[:username] = username
      session[:user_id] = user.id

      puts ""
      puts "here is session in login" 
      pp session
      puts ""

      {
        success: true,
        message: "Login successful. Cookie that preserves this login will be attached to all responses IF AND ONLY IF you send all future requests with credentials--check the docs for your ajax client",
      }.to_json
    else
      {
        success: false,
        message: "Invalid username or password"
      }.to_json

    end
  end


  post '/register' do
    user = User.new

    user.username = @payload[:username]
    user.password = @payload[:password]
    user.save
    session[:logged_in] = true
    session[:username] = user.username
    session[:user_id] = user.id
    puts ""
    puts "hitting register route, here is session:"
    pp session
    puts ""
    {
      success: true,
      message: "You are logged in and have a cookie"
    }.to_json

  end

  get '/logout' do
    session.destroy
    {
      success: true,
      message: "You are now logged out goodbye have a nice day"
    }.to_json
  end

end