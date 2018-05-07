class ItemController < ApplicationController


  # index route
  get '/' do

    @items = Item.all # delete this and replace with: 

    {
      success: true,
      message: "Successfully retrieved #{@items.length} items.",
      retrieved_items: @items
    }.to_json

  end

  # show route
  get '/:id' do
    Item.find(params[:id])
    {
      success: true,
      message: "Found item #{@item.id}",
      found_item: @item
    }

  end

  # create route
  post '/' do

    # this is how you add something with ActiveRecord.  
    @item = Item.new
    @item.title = params[:title]
    @item.save

    # session[:message] = "You added item \##{@item.id}."

    # again-- we could (and in gneral should write code to send back a seimialr error response if there was an error)
    {
      success: true,
      message: "Item #{@item.id} successfully created",
      added_item: @item
    }.to_json

  end

  # destroy route  
  delete '/:id' do
    # there are many ways to do this find statement, this is just one
    # remember you can play around with ActiveRecord by adding binding.pry 
    # and trying stuff out
    @item = Item.find params[:id]
    @item.destroy

    # in general you might send back one response for sucessful operation  (below) and 
    # maybe you might write logic to send back a error response if there's an error, 
    # similar to the one below but
    # success: false and message: "here's what went wrong"

    {  
       success: true,
       message: "You deleted item \##{@item.id}",
       deleted_item: @item
    }.to_json

  end

  # edit route
  # deleted


  # update route
  patch '/:id' do
    # like i said -- lots of ways to do this.  
    # http://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html
    # http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where
    @item = Item.find(params[:id]) 
    # later we'll do more work here
    @item.title = params[:title]
    @item.save

    {
      success: true,
      message: "You updated item \##{@item.id}",
      updated_item: @item
    }.to_json

  end

end