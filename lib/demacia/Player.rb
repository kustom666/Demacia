module Demacia
	class Player
		attr_accessor :champion_id, :summoner_id , :team_id

		def initialize(champion_id, summoner_id , team_id)
			@champion_id = champion_id
			@summoner_id = summoner_id
			@team_id = team_id
		end
	end
end