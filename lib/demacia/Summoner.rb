require 'json'
require 'open-uri'
require 'openssl'

module Demacia
	class Summoner
		attr_accessor :masteries, :runes, :profile_icon, :name, :id, :level

		# Class constructor, gets the basic Summoner info from riot api. Does not auto load the masteries nor runes
		# Params:
		# +query_string+:: The full query string forged from name, entry point and method
		def initialize(query_string)
			answer_string = open(query_string).read
			parsed_answer = JSON.parse(answer_string)
			@level = parsed_answer["summonerLevel"]
			@profile_icon = parsed_answer["profileIconId"]
			@name = parsed_answer["name"]
			@id = parsed_answer["id"]
		end

		def load_masteries

		end

		def load_runes
		end
	end
end