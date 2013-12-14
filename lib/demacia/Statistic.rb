module Demacia
	class Statistic
		attr_accessor :id, :name, :value

		def initialize(id, name, value)
			@id = id
			@name = name
			@value = value
		end
	end
end