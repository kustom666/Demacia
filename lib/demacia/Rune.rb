module Demacia
	class Rune
		attr_accessor :id, :description, :name, :tier, :slot_id

		def initialize(id, description, name, tier, slot_id)
			@id = id
			@name = name
			@tier = tier
			@description = description
			@slot_id = slot_id
		end
	end
end