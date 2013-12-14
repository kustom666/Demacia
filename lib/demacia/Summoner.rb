require 'json'
require 'open-uri'
require 'openssl'
require 'Page'
require 'Talent'
require 'Rune'
require 'Tome'
require 'Game'

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
			begin
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
			rescue Exception => e
				puts "An error occured when retreiving the summoner's masteries : "
				puts e.message
			end
		end

		# Loads runes based on an api key. The runes are sorted by their slot id
		# Params:
		# - +key+:: the full query string forged from name, entry point and method
		def load_runes!(key)
			@runes = Array.new
			begin
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
			rescue Exception => e
				puts "An error occured when retreiving the summoner's runes : "
				puts e.message
			end
		end

		def last_ten_games(key)
			answer_string = open("http://prod.api.pvp.net/api/lol/" + @region +"/v1.1/game/by-summoner/"+@id.to_s+"/recent?api_key="+key).read
			parsed_answer = JSON.parse(answer_string)
			games = Array.new
			parsed_answer["games"].each do |game|
				game_buffer = Game.new(game["gameId"],game["championId"],game["createDate"], game["fellowPlayers"], game["gameMode"], game["gameType"], game["invalid"], game["level"], game["mapId"], game["spell1"], game["spell2"], game["statistics"], game["subType"], game["teamId"])
				games << game_buffer
			end
			games
		end

		# Prints the summoner info to the console in a friendly way
		def to_s
			return_string = "\t\tSummoner\n"+
			 				"\nName:\t\t"+@name+
							"\nID:\t\t"+@id.to_s+
							"\nLevel:\t\t"+@level.to_s+
							"\nIcon ID:\t"+@profile_icon.to_s
			if masteries.nil? || masteries.empty?
				return_string << "\nNo masteries"
			else
				masteries.each do |page|
					return_string << "\tMastery Page\n\t"+ page.to_s
				end
			end
		end
	end
end