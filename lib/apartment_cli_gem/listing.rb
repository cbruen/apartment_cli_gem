
class ApartmentCliGem::Listing

	attr_accessor :id, :description, :price, :path

	@@all = []

	def initialize
	end

	def save
		@@all << self
	end

	def self.find_by_id(id)
		found = self.all.select{|x| x.id == id.to_i}[0]
		found
	end

	def self.all
		@@all
	end

end
