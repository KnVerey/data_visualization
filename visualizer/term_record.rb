class TermRecord
	attr_accessor :source_lang_term, :translation, :id

	def initialize(source_lang_term, translation)
		@source_lang_term = source_lang_term
		@translation = translation
		@id = 0
	end

	def output_record
		id.to_s + ": " + source_lang_term + "\t\t" + translation
	end

end