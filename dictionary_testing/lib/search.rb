require_relative './base_page.rb'

class Search < BasePage 
	
	def search_results 
		@browser.querySelectorAll '#grid_cells a img'
	end

	def search_bar 
		@browser.querySelector 'input[name="searchterm"]'
	end

	def grid_cell 
		@browser.querySelector '#grid_cells'
	end
end