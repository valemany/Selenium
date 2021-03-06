require 'selenium-webdriver'

class Browser
	attr_reader :driver
	SITE ||= ENV['SITE']

	def initialize
		@driver = Selenium::WebDriver.for :firefox
	end

	# Maximum amount of seconds for a task to wait before timing out
	# @driver.manage.timeouts.implicit_wait = 5

	def quit
		@driver.quit
	end

	def querySelector(selector)
		@driver.find_element :css => selector
	end

	def querySelectorAll(selector)
		@driver.find_elements :css => selector
	end

	def wait(timeout=10)
		Selenium::WebDriver::Wait.new :timeout => timeout
	end

	def visit(location = '/')
		@driver.navigate.to "http://#{SITE}/#{location}"
	end

	def navigate_to(url = '')
		@driver.navigate.to url
	end
end