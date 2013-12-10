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
	end
end