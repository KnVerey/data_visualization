class Glossary
	attr_reader :chapter_list

	def initialize(description, csv_data, reverse=false)
		@all_records = []
		@id_to_assign = 0
		@description = description

		if reverse; source_lang_term = 1; translation = 0
		else; source_lang_term = 0; translation = 1; end

		csv_data.each { |record| @all_records << TermRecord.new(record[source_lang_term], record[translation]) }
		sort_records
		assign_ids
	end

	def sort_records
		@all_records.sort_by! {|record| record.source_lang_term.remove_accents }
	end

	def assign_ids
		@all_records.each do |record|
			record.id = @id_to_assign
			@id_to_assign += 1
		end
	end

	def chapter_list
		all_char1s = @all_records.map do |record| 
			term_char1 = record.source_lang_term[0].remove_accents

			%w[1 2 3 4 5 6 7 8 9 0].include?(term_char1) ? "#" : term_char1.upcase
		end
		return all_char1s.uniq.sort.to_s
	end

	def output_records_at(letter)
		@all_records.each do |record|
			term_char1 = record.source_lang_term[0]

			if letter=="#"
				record.output_record if %w[1 2 3 4 5 6 7 8 9 0].include?(term_char1)
			elsif term_char1.remove_accents.upcase == letter.remove_accents.upcase
				record.output_record 
			end
		end
	end
end

class String

	def remove_accents
		self.tr('ÀàÂâÄäÉéÈèÊêËëÎîÏïÔôÖöÛûÜüÙùÇç','aaaaaaeeeeeeeeiiiioooouuuuuucc')
	end

end