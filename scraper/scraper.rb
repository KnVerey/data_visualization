require 'nokogiri'
require 'open-uri'	
require 'CSV'

require './irb_glossary.rb'
require './dict_chapter.rb'
require './term_record.rb'

def populate_glossary(glossary, addresses)
	addresses.each do |url|
		page = Nokogiri::HTML(open(url))
		glossary_data = page.css(' #ctl00_PlaceHolderMain_ctl00__ControlWrapper_RichHtmlField p')
		glossary.add_data(glossary_data)
	end
end

def write_to_csv(glossary)
	output = CSV.open("./irb_glossary.csv","w")

	glossary.chapter_list.each do |chapter|
		chapter.entries.each do |record|
			output << [record.english, record.french]
		end
	end
	output.close
end


en_fr_glossary = IRBGlossary.new
en_fr_addresses = ["http://www.irb-cisr.gc.ca/Eng/BoaCom/pubs/Pages/GloLexAk.aspx", "http://www.irb-cisr.gc.ca/Eng/BoaCom/pubs/Pages/GloLexLz.aspx"]
populate_glossary(en_fr_glossary, en_fr_addresses)

write_to_csv(en_fr_glossary)

#TEST
# puts "EN-FR GLOSSARY"
# en_fr_glossary.chapter_list.each {|chapter| puts "*" + chapter.name.to_s}
# en_fr_glossary.chapter_list.each {|chapter| puts chapter.entries[0].english + "\t" + chapter.entries[0].french}
