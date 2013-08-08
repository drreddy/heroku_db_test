class StaticPagesController < ApplicationController
  def home
  	require 'nokogiri'
    require 'open-uri'
    proxy = "http://10.3.100.212:8080/"
	url = "http://www.tastekid.com/"
	if (proxy == "")
			doc = Nokogiri::HTML(open(url))
		else
			doc = Nokogiri::HTML(open(url,:proxy =>proxy))
		end
	/@heading = doc.css(".resourcelist h2").text/
	@simsearch_datatype = Array.new()
	x = 0
	doc.css(".rsrc").each do |link|
	     @simsearch_datatype[x] = link["data-type"]

	     x = x+1
	  end
	doc.css(".rsrc span").each do
	     @simsearch = doc.css(".rsrc span").map(&:text).join(" | ")
	  end
	@similarities = @simsearch.split(" | ")
	@similarities.each do |sim|
		@book = ScrapeData.new
		@book.save
	end
  end
end
