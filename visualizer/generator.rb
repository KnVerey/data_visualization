# require 'erb'
# require 'sinatra'
# require 'debugger'
require 'csv'

require './glossary.rb'
require './term_record.rb'


#required format: lang1_term, lang2_term
csv_data = CSV.read("irb_glossary.csv")

#pass in 2nd param true if lang2 is source language
en_fr_glossary = Glossary.new(csv_data)
fr_en_glossary = Glossary.new(csv_data, true)

#TESTS FOR OUTPUT
# en_fr_glossary.output_records_at("1")
# en_fr_glossary.output_records_at("#")
# en_fr_glossary.output_records_at("D")
fr_en_glossary.output_records_at("D")
