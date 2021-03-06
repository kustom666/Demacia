module Demacia
	# Represents a LoL talent in a page
	class Talent
		attr_accessor :id, :name, :rank

		# Constructor, initializes the talent
		# Params:
		# +id+:: The talent's internal id provided by riot
		# +name+:: The talent's name
		# +rank+:: The talent's rank, aka its level in the talents page (1-2-3-4)
		def initialize(id, name, rank)
			@id = id
			@name = name
			@rank = rank
		end

		def to_s
			return_string = "\nTalent id: \t"+@id.to_s + 
							"\nTalent name:\t"+@name + 
							"\nTalent rank:\t"+@rank.to_s
		end
	end
end