#!/usr/bin/env ruby

require 'selenium-webdriver'
require 'csv'
require 'rspec'
require 'pry'
require 'colorize'

RSpec.configure do |config|
	config.run_all_when_everything_filtered = true

	config.before(:each) do
    	@browser = Browser.new 
  	end

  	config.after(:each) do
    	@browser.quit
  	end
end