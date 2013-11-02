class DictChapter
	attr_reader :name, :entries, :id_to_assign

	def initialize(alpha)
		@name = alpha.upcase
		@entries = []
		@id_to_assign = 0
	end

	def add_record(source, target)
		@entries << TermRecord.new(source, target, @id_to_assign)
		@id_to_assign += 1
	end

	def output_entries
		@entries.each do |record|
			record.output_record
		end
	end
end