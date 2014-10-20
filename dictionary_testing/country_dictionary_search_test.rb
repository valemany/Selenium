#!/usr/bin/env ruby
# This script grabs search terms from a csv/excel file and tests if there are search results for those. 

require 'csv'
require 'rspec'
require 'pry'
require 'colorize'


Dir["./lib/*"].each {|file| require file }

describe 'Dictionary search test based on country code' do
	before :all do
		@browser = Browser.new 
		@search = Search.new @browser
		@language ||= "zh/"
		@test_data =  ["一关", "一关市", "一宮", "一宮市", "丁卡文"]  
		@total_pass = 0
		@total_fail = 0 
		puts "Running test using #{@language} language".colorize(:blue)
	end

	after :each do
		puts "Total pass = #{@total_pass}".colorize(:green)
		puts "Total fail = #{@total_fail}".colorize(:red)
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
					@total_pass += 1
				end 
			rescue Exception 
				puts "Did not return search results for #{data}"
			ensure	
				@total_fail += 1
			end
  		end
  	end
end