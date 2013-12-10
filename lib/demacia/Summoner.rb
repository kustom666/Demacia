require 'json'
require 'open-uri'
require 'openssl'
require 'Page'
require 'Talent'
require 'Rune'

module Demacia
	class Summoner
		attr_accessor :masteries, :runes, :profile_icon, :name, :id, :level

		# Class constructor, gets the basic Summoner info from riot api. Does not auto load the masteries nor runes
		# Params:
		# +query_string+:: The full query string forged from name, entry point and method
		def initialize(query_string)
			answer_string = open(query_string).read
			parsed_answer = JSON.parse(answer_string)
			puts parsed_answer
			@level = parsed_answer["summonerLevel"]
			@profile_icon = parsed_answer["profileIconId"]
			@name = parsed_answer["name"]
			@id = parsed_answer["id"]
			puts parsed_answer["id"]
		end

		# Loads masteries based on a query to query string.
		# Params:
		# +query_string+:: the full query string forged from name, entry point and method
		def load_masteries(query_string)
			@masteries = Array.new
			answer_string = open(query_string).read
			parsed_answer = JSON.parse(answer_string)
			parsed_answer["pages"].each do |key, page| 
				page_buffer = Demacia::Page.new(page["name"], page["current"])
				page["talents"].each do |talent_key, talent|
					talent_buffer = Demacia::Talent.new(talent["id"], talent["name"], talent["rank"])
					page_buffer.talents << talent_buffer
				end
				@masteries << page_buffer
			end
		end

		# Loads runes based on a query to query string. The runes are sorted by their slot id
		# Params:
		# +query_string+:: the full query string forged from name, entry point and method
		def load_runes(query_string)
			@runes = Array.new
			answer_string = open(query_string).read
			parsed_answer = JSON.parse(answer_string)

			parsed_answer["pages"].each do |key, page|
				rune_buffer = page["rune"]
				rune_out = Rune.new(rune_buffer["id"],rune_buffer["description"],rune_buffer["name"],rune_buffer["tier"], page["runeSlotId"])
				@runes << rune_out
			end
			@runes.sort { |a, b| a.slot_id <=> b.slot_id }
		end
	end
end