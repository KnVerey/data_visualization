require 'erb'
require 'csv'

require './glossary.rb'
require './term_record.rb'

# include ERB::Util

template = File.read("glossary.html.erb")
csv_data = CSV.read("irb_glossary.csv")

en_fr_glossary = Glossary.new("English to French",csv_data)
# fr_en_glossary = Glossary.new("French to English",csv_data, true)

html = ERB.new(template, nil, ">").result(en_fr_glossary.get_binding)

File.open("glossary.html","w") {|file| file.puts html }