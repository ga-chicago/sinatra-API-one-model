class ItemController < ApplicationController

  # index route
  get '/' do
    @items = Item.all # beautiful isn't it
    # @items.to_json
    @page = "Index of items"
    erb :item_index
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

    pp params

    # this is how you add something with ActiveRecord.  
    @item = Item.new
    @item.title = params[:title]
    @item.user_id = 1 # for now
    @item.save

    # hey there's a .to_json method. cool.
    # @item.to_json # we will come back to this

    redirect '/items'

  end

end