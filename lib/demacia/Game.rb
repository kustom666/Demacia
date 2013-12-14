require 'Player'
require 'Statistic'

module Demacia
	class Game
		attr_accessor :id ,:champion_id, :play_date, :fellow_players, :mode, :type, :invalid, :level, :map, :spell_a, :spell_b, :sub_type, :team_id, :stats
		
		def initialize(id, champion_id, play_date, fellow_players, mode, type, invalid, level, map, spell_a, spell_b, stats, sub_type, team_id )
			@id = id, @champion_id = champion_id, @play_date = play_date, @mode = mode, @type = type
			@invalid = invalid, @level = level, @map = map, @spell_a = spell_a, @spell_b = spell_b, @sub_type = sub_type, @team_id = team_id

			@stats = Array.new
			stats.each do |statistic|
				buffer_stat = Statistic.new(statistic["id"], statistic["name"], statistic["value"])
				@stats.push(buffer_stat)
			end

			@fellow_players = Array.new
			fellow_players.each do |player|
				buffer_player = Player.new(player["championId"], player["summonerId"], player["teamId"])
				@fellow_players.push(buffer_player)
			end
		end
	end
end