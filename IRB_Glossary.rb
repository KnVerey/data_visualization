require 'nokogiri'
require 'open-uri'	

require './dict_chapter.rb'
require './term_record.rb'

class IRBGlossary
	attr_reader :chapter_list

	def initialize
		@chapter_list = []
	end

	def add_data(term_list)
		create_first_chapter(term_list[0].text)

		term_list.each do |term_data|
			term = term_data.text

			if is_heading?(term)
				add_chapter(term)
			else
				current_chapter = @chapter_list[-1]

				if is_french_translation?(term_data)
					related_english = current_chapter.entries[current_chapter.id_to_assign-1]
					related_english.add_translation(term)
				else
					current_chapter.add_record(term)
				end
			end
		end
		puts @chapter_list[-1].entries[-1].english
	end

	def create_first_chapter(first_term)
		is_heading?(first_term) ? add_chapter(first_term) : add_chapter("NUM")
	end

	def is_heading?(term)
		term.length==1
	end

	def is_french_translation?(term_data)
		term_data.css("span").to_s.include? "fr"		
	end

	def add_chapter(name)
		@chapter_list << DictChapter.new(name)
	end
end

#SCRAPE A-K
page = Nokogiri::HTML(open("http://www.irb-cisr.gc.ca/Eng/BoaCom/pubs/Pages/GloLexAk.aspx"))
term_list = page.css(' #ctl00_PlaceHolderMain_ctl00__ControlWrapper_RichHtmlField p')

#SCRAPE L-Z
page = Nokogiri::HTML(open("http://www.irb-cisr.gc.ca/Eng/BoaCom/pubs/Pages/GloLexLz.aspx"))
term_list2 = page.css(' #ctl00_PlaceHolderMain_ctl00__ControlWrapper_RichHtmlField p')

enfr_glossary = IRBGlossary.new
enfr_glossary.add_data(term_list)
enfr_glossary.add_data(term_list2)

# enfr_glossary.chapter_list.each {|chapter| puts chapter.name}

#WILL NEED TO DO EVERYTHING A SECOND TIME FOR FR-EN

# File.open('IRB_glossary.html','w') do |f|
# 	f.puts("<html>")
# 	f.puts("<head>")
# 	f.puts("	<title>IRB Glossary Reformatted</title>")
# 	f.puts("</head>")
# 	f.puts("<body>")
# 	f.puts("<h1>Immigration and Refugee Board Glossary</h1>")
# 	f.puts("<ul>")

# 	f.puts("</ul")
# 	f.puts("</body>")
# 	f.puts("</html>")
# end

