class ApplicationController < Sinatra::Base


use Rack::Session::Cookie,  :key => 'rack.session',
                              :path => '/',
                              :secret => 'your_secret'


  require 'bundler'
  Bundler.require()

  register Sinatra::CrossOrigin

  ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'item2'
  )

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


  configure do
    enable :cross_origin
  end


  set :allow_methods, [:get, :post,:delete, :put, :options]


  options '*' do
    p "opi"
    response.headers['Allow'] = 'HEAD, GET, POST, PUT, PATCH, DELETE'
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
  end


end
