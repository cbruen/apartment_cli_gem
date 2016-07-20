require 'pry'
class ApartmentCliGem::Scraper


def initialize(city)
	@one = 0
	@more = "more"
	@city = city
	@full = true
end

def group
	@group = ApartmentCliGem::Listing.find_by_city(@city)
	if @group.empty?
		@nested = Nokogiri::HTML(open("http://#{@city}.craigslist.org/roo/")).css('div.rows p.row')
		self.save_listings
		self.group
	end
end

def save_listings
	count = 1
	@nested.each do |x|
		listing = ApartmentCliGem::Listing.new
		listing.id= count
		listing.city = @city
		listing.path = x.css('a')[0]['href']
		description = x.css('span.pl').text.split("?>  ")[1].match(/(?<=\d\s).*/).to_s[0,35] + "..."
		listing.description = description
		listing.price= x.css('span.price').text

		listing.save
		count+=1
end
end

def list(arr)
	arr[@one,20].each do |y|
		length_first = 2-"#{y.id}".length
		space_first = ""
		(1..length_first).each { |x| space_first+= " "}
		length_second = 41 - y.description.length
		space_second = ""
		(1..length_second).each {|x| space_second +=" "}
		puts "#{y.id}.  " + space_first + y.description + space_second + y.price
	end
end


def increment
	@full ? arr = @group : arr = ApartmentCliGem::Listing.favorites
	while (@more == "more" || @more == "back") && !arr[@one].nil?
		self.list(arr)
		puts "\n\n\nType the corresponding number to see more details, or\n\n   \"more\"       to see additional listings\n"
		puts "   \"back\"       to view the previous set of listings"
		puts "   \"home\"       to search by a new city"
		puts "   \"favorites\"  to view bookmarked listings" if @full == true
		@more = gets.chomp
		case
			when @more.split(".")[0].to_i > 0
				 self.new_page(@more)
			when @more == "home"
				 ApartmentCliGem::Run.run
			when @more == "back" && @one != 0
					@one-=20
			when @more == "back" && @one == 0 && !@full
					@full = true
					@one = @last
					self.increment
			when @more == "more"
					@one+=20
			when "favorites"
					@full = false
					@one = 0
					if ApartmentCliGem::Listing.favorites.empty?
						puts "You have no listings saved"
						@full = true
					end
					@more = "more"
					self.increment
			end
	end
 ApartmentCliGem::Run.run
end


def new_page(id)
	listing = ApartmentCliGem::Listing.find_by_id(@more.to_i, @city)
			if !listing.nil?
				page = ApartmentCliGem::ListingPage.new(@city, listing.path)
				page.show
				puts "\n\n\nType:\n"
				puts "   \"save\"       to add this listing to your favorites" unless ApartmentCliGem::Listing.favorites.include?(listing)
				puts "   \"back\"       to view the previous set of listings"
				puts "   \"home\"       to search by a new city"
				puts "   \"favorites\"  to view bookmarked listings"
				answer = gets.chomp
					case answer
						when "save"
							 listing.favorite
							 @last = @one
							 @one = 0
							 @more = "more"
							 @full = false
							 puts "Favorites:"
							 self.increment
						when "back"
							 @more = "more"
							 self.increment
						when "home"
						  	ApartmentCliGem::Run.run
						when "favorites"
								@full = false
								@one = 0
								if ApartmentCliGem::Listing.favorites.empty?
									puts "You have no listings saved"
									@full = true
								end
								self.increment
						end
			else
				puts "No listing found"
			end

end

end
