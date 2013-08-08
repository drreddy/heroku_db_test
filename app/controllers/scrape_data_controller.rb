class ScrapeDataController < ApplicationController
	def home
  	require 'nokogiri'
    require 'open-uri'
    proxy = "http://10.3.100.212:8080/"
    @dbent = ScrapeData.order(:name)
    @dbent.each do |data|
    	case data.data_type
		when "m"
		  	type = "movies"
		when "s"
		  	type = "music"
		when "b"
			type = "books"
		when "a"
			type = "authors"
		when "h"
			type = "shows"
		when "g"
			type = "games"
		else
			type = "none"	  
		end
		url = "http://www.tastekid.com/like/#{CGI::escape(data.name)}/#{CGI::escape(type)}"
		doc = Nokogiri::HTML(open(url,:proxy =>proxy))
		@simsearch_datatype = Array.new()
		x = 0
		doc.css(".resourcelist span").each do
		     @simsearch = doc.css(".resourcelist span").map(&:text).join(" | ")
		     @simsearch_datatype[x] = data.data_type
		     x = x+1
		end
		@similarities = @simsearch.split(" | ")
		x = 0
		@similarities.each do |sim|
			db = ScrapeData.new
			db.name = sim
			db.data_type = @simsearch_datatype[x]
		  	db.save
		  	x = x+1
		end
		@dbentries = ScrapeData.count
	end
	/@dbent = ScrapeData.order(:name)
	flash.now[:success] = @dbentries
	ScrapeData.destroy_all
	redirect_to root_path/
  end
end
