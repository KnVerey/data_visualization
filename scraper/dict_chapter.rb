class DictChapter
	attr_reader :name, :entries, :id_to_assign

	def initialize(alpha)
		@name = alpha
		@entries = []
		@id_to_assign = 0
	end

	def add_record(english)
		@entries << TermRecord.new(english, @id_to_assign)
		@id_to_assign += 1
	end
end