require 'json'
require 'open-uri'
require 'openssl'
require 'demacia/Summoner.rb'

module Demacia
	class Caller
		attr_accessor :api_key, :entry_point, :api_suffix, :region

		# Initializes the Caller with an api key (needed)
		# Params:
		# +key+:: the api key provided by riot 
		# +region+:: the region where the requests have to be made. Can be one of the following : tr,br,na,euw,eune
		def initialize(key, region)
			@api_key = key
			@region = region
			@api_suffix = "?api_key=" + @api_key
			@entry_point = "http://prod.api.pvp.net/api/lol/" + @region +"/v1.1/"
		end

		# Gets a summoner's info from riot's API based on its name
		# Params:
		# +name+:: The summoner name (nickname). NOT the account name
		def getSummonerByName(name)
			summoner = Demacia::Summoner.new(@entry_point+"summoner/by-name/"+name+@api_suffix)
			summoner
		end
	end
end