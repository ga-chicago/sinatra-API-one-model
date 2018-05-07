class ApplicationController < Sinatra::Base

  require 'bundler'
  Bundler.require()

  ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql', 
    :database => 'item2'
  )

  use Rack::MethodOverride  # we "use" middleware in Rack-based libraries/frameworks
  set :method_override, true

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