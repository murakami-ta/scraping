require 'open-uri'
require 'nokogiri'
require "pry"
require 'csv'

[
"http://mountain-c.com/media/10987",
"http://mountain-c.com/media/10944",
"http://mountain-c.com/media/10964",
"http://mountain-c.com/media/10951",
"http://mountain-c.com/media/10989",
"http://mountain-c.com/media/11000",
"http://mountain-c.com/media/11012",
"http://mountain-c.com/media/11026",
"http://mountain-c.com/media/11042",
"http://mountain-c.com/media/11060",
"http://mountain-c.com/media/11071",
"http://mountain-c.com/media/11080",
"http://mountain-c.com/media/11093",
"http://mountain-c.com/media/11104",
"http://mountain-c.com/media/11117",
"http://mountain-c.com/media/11131",
].each do |url|
  doc = Nokogiri::HTML(open(url))
  puts doc.css("h1").text
end
