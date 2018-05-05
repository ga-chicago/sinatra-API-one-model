class ItemController < ApplicationController

  # index route
  get '/' do
    "this is get route in ItemController"
  end

  # add route 
  get '/add' do
    @page = "Add Item"
    @action = "/items"
    @method = "POST"
    @placeholder = "Enter your item!"
    @value=""
    @buttontext = "Add Item"
    erb :add_item # this view will be created in the next step
  end

  post '/' do
    # params are in a hash called params, check your terminal
    # extra puts statements help you find this output amongst the very verbose terminal output
    puts "HERE IS THE PARAMS---------------------------------------"
    pp params
    puts "---------------------------------------------------------"
    "you posted. check your terminal."
  end

end