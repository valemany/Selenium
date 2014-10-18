#!/usr/bin/env ruby
# This script grabs search terms from a csv/excel file and tests if there are search results for those. 

require 'selenium-webdriver'
require 'csv'
require 'rspec'
require 'pry'


describe 'Dictionary search test based on country code' do
	before :all do
		@driver = Selenium::WebDriver.for :firefox
		SITE ||= ENV['SITE']
		@language ||= "/cs/"
		ABV_KEY ||= '&abv=123-10327-968114b331e63934f88562b8e81867e8'
	end

	after :all do
		@driver.quit
	end

	it 'Should display search results for every search term' do 
#Iterate through the Sheet reading Rows line by line
		CSV.foreach(File.expand_path("test_data.csv"),encoding: "iso-8859-1:UTF-8", headers:true) do |row|
			# binding.pryUTF-16LE:UTF-8 iso-8859-1:UTF-8
				begin
				seatch_term = CGI.escape(row[0])
				@driver.navigate.to ("http://#{SITE}" + @language + "cat.mhtml?searchterm=#{seatch_term}" + ABV_KEY)
				sleep 1
				search_results = @driver.find_elements(:css, '#grid_cells a img')
				puts "Search term #{row[0]} - PASSED" if expect(search_results.length).to be > 0 
				rescue Exception 
					puts "Did not return search results for #{row[0]}"
				end

  		end
  	end
end