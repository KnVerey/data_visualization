class IRBGlossary
	attr_reader :chapter_list

	def initialize
		@chapter_list = []
	end

	def add_data(term_list)
		create_first_chapter(term_list[0].text)

		term_list.each do |term_data|
			term = term_data.text

			if is_heading?(term) && (@chapter_list[-1].name != term)
				add_chapter(term)
			elsif @chapter_list[-1] == term
					#do nothing
			else
				current_chapter = @chapter_list[-1]

				if is_french_translation?(term_data)
					related_english = current_chapter.entries[current_chapter.id_to_assign - 1]
					related_english.add_translation(term)
				else
					current_chapter.add_record(term)
				end
			end
		end
		# puts @chapter_list[-1].entries[-1].english
	end

	def create_first_chapter(first_term)
		is_heading?(first_term) ? add_chapter(first_term) : add_chapter("NUM")
	end

	def is_heading?(term)
		term.length == 1
	end

	def is_french_translation?(term_data)
		term_data.css("span").to_s.include? "fr"		
	end

	def add_chapter(name)
		@chapter_list << DictChapter.new(name)
	end
end