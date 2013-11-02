# require 'erb'
# require 'sinatra'
require 'csv'

require './glossary.rb'
require './dict_chapter.rb'
require './term_record.rb'


#required format: English, French
csv_data = CSV.read("irb_glossary.csv")
en_fr_glossary = Glossary.new(csv_data)

en_fr_glossary.chapter_list[23].output_entries