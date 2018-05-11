class ApplicationController < Sinatra::Base

  require 'bundler'
  Bundler.require()

  ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql', 
    :database => 'item2'
  )
  
  use Rack::Session::Cookie,  :key => 'rack.session',
                              :path => '/',
                              :secret => 'your_secret'


  #### ADDED FOR CORS ####
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
  end

  set :allow_methods, [:get, :post, :delete, :put, :patch, :options]

  options '*' do
    p "options"
    response.headers['Allow'] = 'HEAD, GET, POST, PUT, PATCH, DELETE'
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  end

  #### end of CORS stuff####

  get '/' do
    {
      success: false,
      message: "Please consult the API documentation"
    }.to_json
  end

  get '*' do
    {
      success: false,
      message: "404 page not found"
    }.to_json
    # halt 404  -- you can use halt to send HTTP error (or success but why?) codes
  end

end