class TermRecord
	attr_accessor :source_lang, :target_lang
	attr_reader :id

	def initialize(source, target, id)
		@source_lang = source
		@target_lang = target
		@id = id
	end

	def output_record
		puts id.to_s + ": " + source_lang + "\t\t" + target_lang
	end

end