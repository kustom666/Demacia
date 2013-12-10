require 'json'
require 'open-uri'
require 'openssl'
require 'htmlentities'
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
		def summoner_by_name(name)
			encoded_name = HTMLEntities.new.encode name
			summoner = Demacia::Summoner.new(@entry_point+"summoner/by-name/"+encoded_name+@api_suffix)
		end

		# Gets a summoner's info from riot's API based on its id
		# Params:
		# +id+:: The summoner id from riot's api
		def summoner_by_id(id)
			summoner = Demacia::Summoner.new(@entry_point+"summoner/"+id+@api_suffix)
		end

		# Gets a summoner's info and masteries from riot's API based on its name
		# Params:
		# +name+:: The summoner name from riot's api
		def summoner_masteries_by_name(name)
			summoner = summoner_by_name(name)
			summoner.load_masteries(@entry_point+"summoner/"+summoner.id.to_s+"/masteries"+@api_suffix)
			summoner
		end

		# Gets a summoner's info and masteries from riot's API based on its id
		# Params:
		# +id+:: The summoner id from riot's api
		def summoner_masteries_by_id(id)
			summoner = summoner_by_id(id)
			summoner.load_masteries(@entry_point+"summoner/"+summoner.id.to_s+"/masteries"+@api_suffix)
			summoner
		end

		# Gets a summoner's info and runes from riot's API based on its name
		# Params:
		# +name+:: The summoner name from riot's api
		def summoner_runes_by_name(name)
			summoner = summoner_by_name(name)
			summoner.load_runes(@entry_point+"summoner/"+summoner.id.to_s+"/runes"+@api_suffix)
			summoner
		end

		# Gets a summoner's info and runes from riot's API based on its id
		# Params:
		# +id+:: The summoner id from riot's api
		def summoner_runes_by_id(id)
			summoner = summoner_by_id(id)
			summoner.load_runes(@entry_point+"summoner/"+summoner.id.to_s+"/runes"+@api_suffix)
			summoner
		end
	end
end