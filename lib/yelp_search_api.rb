#API wrapper for Yelp API
require 'rubygems'
require 'oauth'
require 'json'
#require_relative "../../app/models/review"

class YelpSearchParser

	 def search_for_yelp_id( term, lat, long)
	 	consumer_key = 'CoPn_PDLyBIom28EwW_vcg'
		consumer_secret = 'v6VqDXMzGUpLEnbCGx6xDAwG4OM'
		token = '8UmXzrrFzbAffWuTpjTiOQkiFKJ3KZzY'
		token_secret = 'uADpLMg0_BuzFaTWP3GOie9qIQU'

		api_host = 'api.yelp.com'

		consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
		access_token = OAuth::AccessToken.new(consumer, token, token_secret)

		#path to use in production, accepting location
		path = "/v2/search?term=#{term}&ll=#{lat},#{long}"
	
		# Using Ruby JSON
		search = JSON.parse(access_token.get(path).body)
		
		return search
		#play with the data
		#location = Array.new

	end

end


