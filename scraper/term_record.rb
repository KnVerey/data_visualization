class TermRecord
	attr_reader :english, :french, :id

	def initialize(english, id)
		@english = english
		@french = ""
	end

	def add_translation(french)
		@french = french
	end

end