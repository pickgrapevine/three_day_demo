require_relative '../../lib/yelp_search_api.rb'

class ReviewsController < ApplicationController

 # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = Review.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/new
  # GET /reviews/new.json
  def new
    @review = Review.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @review }
    end
  end

  # GET /reviews/1/edit
  def edit
    @review = Review.find(params[:id])
  end

  # POST /reviews
  # POST /reviews.json
  def create
	  @info = params[:review]
		@name = @info[:name]
		@lat = @info[:lat]
		@lng = @info[:lng]
		@address = @info[:address]
		@phone = @info[:phone]
	  @email = @info[:email]
    
		# parser =  YelpSearchParser.new 
		results = search_for_yelp_id(@name, @address)
		$stderr.puts results
    business = results["businesses"][0]
		
    review_hash = {'rating' => business["rating"], 'comment' => business["snippet_text"] }
		@review = Review.new(review_hash)

		respond_to do |format|
        format.html { render action: "show" }
    end
  end

  # PUT /reviews/1
  # PUT /reviews/1.json
  def update
    @review = Review.find(params[:id])

    respond_to do |format|
      if @review.update_attributes(params[:review])
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_url }
      format.json { head :ok }
    end
  end


	private
	 def search_for_yelp_id( term, address)
	 	consumer_key = 'CoPn_PDLyBIom28EwW_vcg'
		consumer_secret = 'v6VqDXMzGUpLEnbCGx6xDAwG4OM'
		token = '8UmXzrrFzbAffWuTpjTiOQkiFKJ3KZzY'
		token_secret = 'uADpLMg0_BuzFaTWP3GOie9qIQU'

		api_host = 'api.yelp.com'

		consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
		access_token = OAuth::AccessToken.new(consumer, token, token_secret)

		#path to use in production, accepting location
		path = "/v2/search?term=#{term}&location=#{address}&limit=1"
	
		# Using Ruby JSON
		search = JSON.parse(access_token.get(path).body)
		
		return search
		#play with the data
		#location = Array.new

	end


end
