class UserController < ApplicationController

  before do

    payload_body = request.body.read

    if(payload_body != "")
      @payload = JSON.parse(payload_body).symbolize_keys
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
    puts "hitting register route. here is the session:"
    pp session
    puts ""

    # here you should check for 
      # blank input -- send back fail, tell em can't be blank
      # does this username already exist -- tell em it's taken etc



    {
      success: true,
      user_id: user.id,
      username: user.username,
      message: "You are logged in as #{user.username} and you now have a cookie with credentialsthat preserves this login attached to all the responses i'm sending you and it will  keep being there IF AND ONLY IF you send it back to me with every request from the client side; how you do this depends on what client you are using to make ajax requests"
    }.to_json


  end

  post '/login' do

    puts ""
    puts "hitting login.  here is session"
    pp session
    puts ""

    username = @payload[:username]
    password = @payload[:password]

    user = User.find_by username: username

    if user && user.authenticate(password)
      session[:logged_in] = true
      session[:username] = username
      session[:user_id] = user.id

      puts ""
      puts "here is session in login after loggin in"
      pp session
      puts ""
      {
        success: true, 
        user_id: user.id,
        username: username,
        message: "Login Successful.  Cookie.....e tc etc etc. remember credentials for all ajax requests"
      }.to_json

    else
      {
        success: false,
        message: "Invalid username or password"
      }.to_json
    end
  end

  get '/logout' do
    session.destroy
    {
      success: true,
      message: "You are now logged out goodbye cya have a nice flight"
    }
  end

end