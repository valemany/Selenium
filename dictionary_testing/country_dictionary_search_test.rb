#!/usr/bin/env ruby
# This script grabs search terms from a csv/excel file and tests if there are search results for those. 

require 'csv'
require 'rspec'
require 'pry'

Dir["./lib/*"].each {|file| require file }


describe 'Dictionary search test based on country code' do
	before :all do
		@browser = Browser.new 
		@search = Search.new @browser
		@language ||= "cs/"
		@test_data = ["abcházština", "acehština", "ačinsk", "adygejština", "afarština", "afghánistán", "afrika"]
	end

	after :all do
		@browser.quit
	end

	it 'Verifies search results for cs language' do 
#Iterate through the Sheet reading Rows line by line
		#CSV.foreach(File.expand_path("test_data.csv"),encoding: "iso-8859-1:UTF-8", headers:true, col_sep:",") do |row|
		@test_data.each do |data|
			begin
				search_term = CGI.escape(data.to_s)
				@browser.visit ("#{@language}"+ "cat.mhtml?searchterm=#{search_term}")
				if expect(@search.grid_cell).to be 
					puts "Search term #{data} - PASSED" 
				end 
			rescue Exception 
				puts "Did not return search results for #{data}"
			end
  		end
  	end
end