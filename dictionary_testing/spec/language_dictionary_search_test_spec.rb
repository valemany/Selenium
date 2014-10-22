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
		@LANGUAGE = ENV['LANGUAGE'].downcase.gsub('@','').to_s
		puts "Running test in #{Browser::SITE} using #{@LANGUAGE} language".colorize(:blue)
		@browser = Browser.new 
		@search = Search.new @browser
	end

	before :each do
		@total_pass = 0
		@total_fail = 0 
		@total_searches = 0 
	end

	after :each do
		puts "##{@total_searches} total searches were performed!".colorize(:green)
		puts "##{@total_fail} searches returned no results".colorize(:red)
		puts "##{@total_pass} search terms returned results using #{@LANGUAGE} language from (#{Browser::SITE})".colorize(:green)
	end

	after :all do
		@browser.quit
	end

	it "Verifies search results for #{@LANGUAGE} language", "#{@LANGUAGE}".to_sym do 
		CSV.foreach(File.expand_path("test_data_#{@LANGUAGE}.csv"),encoding: "UTF-8", headers:true, col_sep:",") do |row|
			begin
				@total_searches += 1
				search_term = CGI.escape(row[0].to_s)
				@browser.visit (@LANGUAGE + "/cat.mhtml?searchterm=#{search_term}")
				if expect(@search.grid_cell).to be 
					puts "Search term #{row[0]} - PASSED" 
					@total_pass += 1
				end 
			rescue Exception
				@total_fail += 1 
				puts "Did not return search results for #{row[0]}".colorize(:yellow)
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