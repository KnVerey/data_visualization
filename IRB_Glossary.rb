require 'nokogiri'
require 'open-uri'	

class IRBGlossary
	def add_data(term_list)
		if term_list[0].text.length==1
			chapter=DictChapter.new(term.text)
		else
			chapter=DictChapter.new("num")
		end

		term_list.each do |term|
			if term.text.length==1
				chapter=DictChapter.new(term.text)
			else
				english = term.text
				french = term.text
			end
		end
	end
end

class DictChapter
	def initialize(alpha)
		@name = alpha.to_sym
		@entries = []
	end

	def add_record
		
	end

end

class TermRecord
	def initialize(english, french)
		@english = english
		@english_alpha = english[0].to_sym
		@french = french
		@french_alpha = french[0].to_sym
	end

end

#SCRAPE A-K
page = Nokogiri::HTML(open("http://www.irb-cisr.gc.ca/Eng/BoaCom/pubs/Pages/GloLexAk.aspx"))
term_list = page.css(' #ctl00_PlaceHolderMain_ctl00__ControlWrapper_RichHtmlField p')

#SCRAPE L-Z
page = Nokogiri::HTML(open("http://www.irb-cisr.gc.ca/Eng/BoaCom/pubs/Pages/GloLexLz.aspx"))
term_list2 = page.css(' #ctl00_PlaceHolderMain_ctl00__ControlWrapper_RichHtmlField p')

puts term_list.each do {|term| puts term.text + "\t" + term.text}

# glossary = IRBGlossary.new.add_data(term_list)
# glossary.add_data(term_list2)

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

