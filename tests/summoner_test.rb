require "test/unit"
require "Demacia"

class SummonerTest < Test::Unit::TestCase
	
	def test_null
		caller = Demacia::Caller.new("44397ab5-7b8f-4eb8-b045-dbfcc039f3b3", "euw")
		summoner = caller.summoner_by_name("Kustoms")
		assert_not_nil(summoner)
	end
	def test_create 
		caller = Demacia::Caller.new("44397ab5-7b8f-4eb8-b045-dbfcc039f3b3", "euw")
		summoner = caller.summoner_by_name("Kustoms")
		assert_equal("Kustoms", summoner.name)
	end
end