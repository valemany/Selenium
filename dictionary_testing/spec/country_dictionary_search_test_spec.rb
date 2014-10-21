#!/usr/bin/env ruby
# This script grabs search terms from a csv/excel file and tests if there are search results for those. 

require 'csv'
require 'rspec'
require 'pry'
require 'colorize'

RSpec.configure { |c| c.run_all_when_everything_filtered = true }

Dir["./lib/*"].each {|file| require file }

describe 'Dictionary search test based on country code' do
	before :all do
		@browser = Browser.new 
		@search = Search.new @browser
	end

	before :each do
		@total_pass = 0
		@total_fail = 0 
	end

	after :each do
		puts "##{@total_pass} search terms returned results using #{@language} language from (#{Browser::SITE})".colorize(:green)
	end

	after :all do
		@browser.quit
	end

	it 'Verifies search results for cs language', :cs do 
		puts "Running test in #{Browser::SITE} using #{@language} language".colorize(:blue)
		CSV.foreach(File.expand_path("test_data_cs.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
			begin
				@language = 'cs/'
				search_term = CGI.escape(row[0].to_s)
				@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
				if expect(@search.grid_cell).to be 
					puts "Search term #{row[0]} - PASSED" 
					@total_pass += 1
				end 
			rescue Exception 
				puts "Did not return search results for #{row[0]}"
			end
  		end
  	end

  	it 'Verifies search results for da language', :da do 
		CSV.foreach(File.expand_path("test_data_da.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
			begin
				@language = 'da/'
				search_term = CGI.escape(row[0].to_s)
				@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
				if expect(@search.grid_cell).to be 
					puts "Search term #{row[0]} - PASSED" 
					@total_pass += 1
				end 
			rescue Exception 
				puts "Did not return search results for #{row[0]}"
			end
  		end
  	end

  	it 'Verifies search results for de language', :de do 
		CSV.foreach(File.expand_path("test_data_de.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
			begin
				@language = 'de/'
				search_term = CGI.escape(row[0].to_s)
				@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
				if expect(@search.grid_cell).to be 
					puts "Search term #{row[0]} - PASSED" 
					@total_pass += 1
				end 
			rescue Exception 
				puts "Did not return search results for #{row[0]}"
			end
  		end	
  	end
end