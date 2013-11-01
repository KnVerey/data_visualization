class TermRecord
	attr_reader :english, :french, :id
	
	def initialize(english, id)
		@english = english
		@id = id
		@french = ""
	end

	def add_translation(french)
		@french = french
	end

end