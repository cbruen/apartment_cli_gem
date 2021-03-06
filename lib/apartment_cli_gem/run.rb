
require 'pry'
class ApartmentCliGem::Run

def self.run

count = 0
city_name = false

	puts "Welcome to the Craigslist Room Lising Scraper!\n\n"
	puts "What city would you like to search for?\n"
	puts "1. Washington D.C.\n2. New York City\n3. San Francisco / Bay Area\n4. Chicago\n5. Los Angeles\n6. Boston"
	puts "(type in the corresponding number)"
	city = gets.chomp

	case city
	when city.split('.')[0].to_i == 9 then puts "hello!"
	when "1" || "1." then city_name = "washingtondc"
	when "2" || "2." then city_name = "newyork"
	when "3" || "3." then city_name = "sfbay"
	when "4" || "4." then city_name = "chicago"
	when "5" || "5." then city_name = "losangeles"
	when "6" || "6." then city_name = "boston"
	else
		puts "invalid submission"
		return
	end

	scrape = ApartmentCliGem::Scraper.new(city_name)
		scrape.group
		scrape.increment

end

end
