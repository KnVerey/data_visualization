require 'nokogiri'
require 'open-uri'	

class IRBGlossary

	def initialize
		@chapter_list = []
	end

	def add_data(term_list)
		term_list[0].text.length==1 ? chapter=DictChapter.new(term.text) : chapter=DictChapter.new("num")

		term_list.each do |term|
			if term.text.length==1
				@chapter_list << chapter
				chapter=DictChapter.new(term.text)
			else

				if term.css.include? "expression"
					chapter.add_record(term.text)
				elsif term.css.include? "translation"
					chapter.entries.last.add_translation(term.text)
				end
			end
		end
	@chapter_list << chapter
	end
end

class DictChapter
	attr_reader :entries

	def initialize(alpha)
		@name = alpha.to_sym
		@entries = []
		@id = 1
	end

	def add_record(english)
		@entries << TermRecord.new(english, id)
		@id += 1
	end

end

class TermRecord
	def initialize(english, id)
		@english = english
		@id = id
		@french = ""
	end

	def add_translation(french)
		@french = french
	end

end

#SCRAPE A-K
page = Nokogiri::HTML(open("http://www.irb-cisr.gc.ca/Eng/BoaCom/pubs/Pages/GloLexAk.aspx"))
term_list = page.css(' #ctl00_PlaceHolderMain_ctl00__ControlWrapper_RichHtmlField p')

#SCRAPE L-Z
page = Nokogiri::HTML(open("http://www.irb-cisr.gc.ca/Eng/BoaCom/pubs/Pages/GloLexLz.aspx"))
term_list2 = page.css(' #ctl00_PlaceHolderMain_ctl00__ControlWrapper_RichHtmlField p')

term_list2.each {|term| puts term.text + "\t" + term.text}


enfr_glossary = IRBGlossary.new.add_data(term_list)
# enfr_glossary.add_data(term_list2)

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

