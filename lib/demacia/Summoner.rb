require 'json'
require 'open-uri'
require 'openssl'
require 'Page'
require 'Talent'
require 'Rune'
require 'Tome'

module Demacia
	class Summoner
		attr_accessor :masteries, :runes, :profile_icon, :name, :id, :level, :region

		# Class constructor, gets the basic Summoner info from riot api. Does not auto load the masteries nor runes
		# Params:
		# - +query_string+:: The full query string forged from name, entry point and method
		# - +region+:: The region in wich the summoner resides
		def initialize(query_string, region)
			answer_string = open(query_string).read
			parsed_answer = JSON.parse(answer_string)
			puts parsed_answer
			@level = parsed_answer["summonerLevel"]
			@profile_icon = parsed_answer["profileIconId"]
			@name = parsed_answer["name"]
			@id = parsed_answer["id"]
			@region = region
		end

		# Loads masteries based on an api key
		# Params:
		# - +key+:: the api key
		def load_masteries!(key)
			@masteries = Array.new
			answer_string = open("http://prod.api.pvp.net/api/lol/" + @region +"/v1.1/summoner/"+@id.to_s+"/masteries?api_key="+key).read
			parsed_answer = JSON.parse(answer_string)
			parsed_answer["pages"].each do |page| 
				talents_buffer = Array.new
				page["talents"].each do |talent|
					talent_buffer = Demacia::Talent.new(talent["id"], talent["name"], talent["rank"])
					talents_buffer << talent_buffer
				end
				page_buffer = Demacia::Page.new(page["name"], page["current"], talents_buffer)
				@masteries << page_buffer
			end
		end

		# Loads runes based on an api key. The runes are sorted by their slot id
		# Params:
		# - +key+:: the full query string forged from name, entry point and method
		def load_runes!(key)
			@runes = Array.new
			answer_string = open("http://prod.api.pvp.net/api/lol/" + @region +"/v1.1/summoner/"+@id.to_s+"/runes?api_key="+key).read
			parsed_answer = JSON.parse(answer_string)
			parsed_answer["pages"].each do |page|
				runes_buffer = Array.new
				page["slots"].each do |slot|
					rune_buffer = slot["rune"]
					rune_out = Rune.new(rune_buffer["id"],rune_buffer["description"],rune_buffer["name"],rune_buffer["tier"], slot["runeSlotId"])
					runes_buffer << rune_out
				end
				runes_buffer.sort { |a, b| a.slot_id <=> b.slot_id }
				tome_buffer = Tome.new(page["id"], page["name"], page["current"], runes_buffer)
				@runes << tome_buffer
			end
		end
	end
end