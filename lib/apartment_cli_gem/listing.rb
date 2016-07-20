require 'pry'
class ApartmentCliGem::Listing

	attr_accessor :id, :description, :price, :path, :city

	@@all = []
	@@favorites = []

	def initialize
	end

	def favorite
		@@favorites << self
		binding.pry
	end

	def self.favorites
		@@favorites
	end

	def save
		@@all << self if ApartmentCliGem::Listing.find_by_id(self.id, self.city).nil?
	end

	def self.find_by_city(city)
		found = self.all.select{|x| x.city == city }
		found
	end

	def self.find_by_id(id, city)
		found = self.all.select{|x| x.id == id && x.city == city}[0]
		found
	end

	def self.all
		@@all
	end

end
