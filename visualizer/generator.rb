require 'erb'
require 'csv'

require './glossary.rb'
require './term_record.rb'

# include ERB::Util

template = File.read("glossary.html.erb")
csv_data = CSV.read("irb_glossary.csv")

en_fr_glossary = Glossary.new("English to French",csv_data)
html = ERB.new(template, nil, ">").result(en_fr_glossary.get_binding)
File.open("en_fr_glossary.html","w") {|file| file.puts html }

fr_en_glossary = Glossary.new("French to English",csv_data, true)
html = ERB.new(template, nil, ">").result(fr_en_glossary.get_binding)
File.open("fr_en_glossary.html","w") {|file| file.puts html }
