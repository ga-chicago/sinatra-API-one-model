class ItemController < ApplicationController


  before do 
    puts ""
    puts "hitting authentication filter in ItemControler, here is session: "
    pp session 
    puts "" 

    if !session[:logged_in]
      {
        success: false,
        message: "you must be logged in to do that"
      }.to_json
    end

  end

  # filter to allow JSON requests to be processed
  before do

    payload_body = request.body.read

    if(payload_body != "")
      @payload = JSON.parse(payload_body).symbolize_keys

      puts "-----------------------------------------------HERE IS OUR PAYLOAD"
      pp @payload
      puts "-----------------------------------------------------------------"

    end
  end


  # index route
  get '/' do
    # just to check
    puts ""
    puts "hitting get '/' (index) route in ItemController, here is session"
    pp session
    puts session.class
    puts ""

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
    @item.title = @payload[:title]
    @item.save

    # session[:message] = "You added item \##{@item.id}."

    # again-- we could (and in gneral should write code to send back a seimialr error response if there was an error)
    # in general, think about what work you're taking on 
    # and what work will be handled by the front end developerx
    # for example:
      # • pagination? 
      # • logic to figure out what happened? and if its what we want? liiike...
      #   • are you gonna send back an item?
      #   • just the one item or all the items?
      # do you need to be communicating with your FE Devs about this?
      # or if its for public consumption what do you need to be sure to explain in your API documentation

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
    @item.title = @payload[:title]
    @item.save

    {
      success: true,
      message: "You updated item \##{@item.id}",
      updated_item: @item
    }.to_json

  end

end