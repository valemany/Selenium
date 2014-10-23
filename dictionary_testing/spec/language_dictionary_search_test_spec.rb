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

	if language.class == Array
		language.each do |lang|
			it "Verifies search results for all languages", :all do 
				puts lang.upcase
				CSV.foreach(File.expand_path("test_data_#{lang}.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
					begin
						@total_searches += 1
						search_term = CGI.escape(row[0].to_s)
						@browser.visit (lang + "/cat.mhtml?searchterm=#{search_term}")
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
	end

  # 	it 'Verifies search results for da language', :da do 
		# CSV.foreach(File.expand_path("test_data_da.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'da/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end
  # 	end

  # 	it 'Verifies search results for de language', :de do 
		# CSV.foreach(File.expand_path("test_data_de.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'de/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end


  # 	it 'Verifies search results for fi language', :fi do 
		# CSV.foreach(File.expand_path("test_data_fi.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'fi/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end

  # 	it 'Verifies search results for hu language', :hu do 
		# CSV.foreach(File.expand_path("test_data_hu.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'hu/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end

  # 	it 'Verifies search results for it language', :it do 
		# CSV.foreach(File.expand_path("test_data_it.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'it/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end

  # 	it 'Verifies search results for ja language', :ja do 
		# CSV.foreach(File.expand_path("test_data_ja.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'ja/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end

  # 	it 'Verifies search results for nb language', :nb do 
		# CSV.foreach(File.expand_path("test_data_nb.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'nb/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end

  # 	it 'Verifies search results for nl language', :nl do 
		# CSV.foreach(File.expand_path("test_data_nl.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'nl/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end

  # 	it 'Verifies search results for pl language', :pl do 
		# CSV.foreach(File.expand_path("test_data_pl.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'pl/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end

  # 	it 'Verifies search results for ru language', :ru do 
		# CSV.foreach(File.expand_path("test_data_ru.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'ru/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end


  # 	it 'Verifies search results for sv language', :sv do 
		# CSV.foreach(File.expand_path("test_data_sv.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'sv/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end

  # 	it 'Verifies search results for th language', :th do 
		# CSV.foreach(File.expand_path("test_data_th.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'th/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end


  # 	it 'Verifies search results for tr language', :tr do 
		# CSV.foreach(File.expand_path("test_data_tr.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'tr/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end

  # 	it 'Verifies search results for zh language', :zh do 
		# CSV.foreach(File.expand_path("test_data_zh.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
		# 	begin
		# 		@language = 'zh/'
		# 		search_term = CGI.escape(row[0].to_s)
		# 		@browser.visit (@language + "cat.mhtml?searchterm=#{search_term}")
		# 		if expect(@search.grid_cell).to be 
		# 			puts "Search term #{row[0]} - PASSED" 
		# 			@total_pass += 1
		# 		end 
		# 	rescue Exception 
		# 		puts "Did not return search results for #{row[0]}"
		# 	end
  # 		end	
  # 	end
end