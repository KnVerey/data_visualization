class TermRecord
	attr_reader :english, :french, :id

	def initialize(english, id)
		@english = english#.gsub("\n", " ")
		@id = id
		@french = ""
	end

	def add_translation(french)
		@french = french#.gsub("\n", " ")
	end

end