class Glossary
	attr_reader :chapter_list

	def initialize(csv_data)
		@chapter_list = []

		add_chapter(csv_data[0][0][0])

		csv_data.each do |record|
			# record[0] = source language
			# record[1] = target language
			# @chapter_list[-1] = current chapter

			add_chapter(record[0][0]) if (record[0][0].downcase != @chapter_list[-1].name.downcase) && record[0][0].to_i == 0

			@chapter_list[-1].add_record(record[0], record[1])
		end
	end

	def add_chapter(name)
		if name.to_i != 0 
			@chapter_list << DictChapter.new("NUM")
		else
			@chapter_list << DictChapter.new(name)
		end
	end
end