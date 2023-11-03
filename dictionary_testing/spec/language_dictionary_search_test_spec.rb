#!/usr/bin/env ruby
# This script grabs search terms from a csv/excel file and tests if there are search 
#results for those using different languages. 

require_relative 'spec_helper'

# RSpec.configure { |c| c.run_all_when_everything_filtered = true }

Dir["./lib/*"].each {|file| require file }

language ||= ENV['LANGUAGE'].downcase.gsub('@','').to_s
	if language == 'all' then
		language = ["cs", "da", "de", "fi", "hu", "it", "ja", "nb", "nl", "pl", "ru", "sv", "th", "tr", "zh"] 
	end

describe 'Dictionary search test based on country code' do
	before :each do
		@search = Search.new @browser
		@total_pass = 0
		@total_fail = 0 
		@total_searches = 0 
	end

	after :each do
		puts "##{@total_searches} total searches were performed!".colorize(:green)
		puts "##{@total_fail} searches returned no results".colorize(:red)
	end

	if language.class != Array
		it "Verifies search results for #{language} language", "#{language}".to_sym do 
			puts "Running test in #{Browser::SITE.upcase} using #{language} language".colorize(:blue)
			CSV.foreach(File.expand_path("test_data_#{language}.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
				begin
				@total_searches += 1
				search_term = CGI.escape(row[0].to_s)
				@browser.visit (language + "/cat.mhtml?searchterm=#{search_term}")
				if @search.grid_cell.displayed?
					puts "Search term #{row[0]} - PASSED" 
					@total_pass += 1
				end
				rescue Selenium::WebDriver::Error::NoSuchElementError
					@total_fail += 1 
					puts "Did not return search results for #{row[0]}".colorize(:yellow)
				end
			end
  		end
  	end
