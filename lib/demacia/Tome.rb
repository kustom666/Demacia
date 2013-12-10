module Demacia
	# Represents a Rune page
	class Tome
		attr_accessor :id, :name, :current, :runes

		def initialize(id, name, current, runes)
			@id = id
			@name = name
			@current = current
			@runes = runes
		end
	end
end
