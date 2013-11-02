class Glossary
	attr_reader :chapter_list

	def initialize(csv_data, reverse=false)
		@chapter_list = []

		if reverse; source = 1; translation = 0
		else; source = 0; translation = 1; end

		add_chapter(csv_data[0][source][0])

		csv_data.each do |record|

			add_chapter(record[source][0]) if (record[source][0].downcase != @chapter_list[-1].name.downcase) && record[source][0].to_i == 0

			@chapter_list[-1].add_record(record[source], record[translation])
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