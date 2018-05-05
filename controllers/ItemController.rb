class ItemController < ApplicationController

  # index route
  get '/' do
    "this is get route in ItemController"
  end

  # add route 
  get '/add' do
    erb :add_item # this view will be created in the next step
  end

end