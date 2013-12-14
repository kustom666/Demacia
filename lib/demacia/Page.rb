module Demacia
	# Represents a rune page 
	class Page
		attr_accessor :name, :current, :talents

		# Constructor, initializes the page with a name and a current 
		# Params:
		# +name+:: The page's name
		# +current+:: A boolean that tells us if this is the currently used page
		def initialize(name, current, talents)
			@name = name
			@current = current
			@talents = talents
		end

		def to_s
			is_used = current ? "yes" : "no"
			return_string = "\nTalent page name:\t"+@name+
							"\nCurrently used:\t"+is_used+
							"\nTalents :\n"
			talents.each do |talent|
				return_string << "\t"+ talent.to_s
			end
		end
	end
end