require 'erb'
require 'sinatra'
require 'csv'

require './glossary.rb'
require './term_record.rb'
require '.glossary.html.erb'

include ERB::Util

#required format: lang1_term, lang2_term
csv_data = CSV.read("irb_glossary.csv")

#pass in 3rd param true if lang2 is source language
en_fr_glossary = Glossary.new("English to French",csv_data)
fr_en_glossary = Glossary.new("French to English",csv_data, true)

ERB.new(glossary.html.erb).result(en_fr_glossary.get_binding)

