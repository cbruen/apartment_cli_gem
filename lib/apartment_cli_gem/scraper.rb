
class ApartmentCliGem::Scraper


def initialize(city)
	@one = 0
	@more = "more"
	@count = 1
	@city = city
	@nested = Nokogiri::HTML(open("http://#{@city}.craigslist.org/roo/")).css('div.rows p.row')
	@nested_new = nil
end

def list
	@nested[@one,20].each do |x|
		listing = ApartmentCliGem::Listing.new
		listing.id= @count
		listing.path = x.css('a')[0]['href']
		description= x.css('span.pl').text.split("?>  ")[1].match(/(?<=\d\s).*/).to_s[0,35] + "..."
		listing.description= description
		listing.price= x.css('span.price').text
		listing.save
		length_first = 2-"#{@count}".length
		space_first = ""
		(1..length_first).each { |x| space_first+= " "}
		length_second = 41 - description.length
		space_second = ""
		(1..length_second).each {|x| space_second +=" "}

		puts "#{@count}.  " + space_first + listing.description + space_second + listing.price


		@count+=1
	end
end



def increment
	while @more == "more" && @one < 100
		self.list
		puts "\n\n\nType the corresponding number to see more details or \"more\" to see more listings."
		@more = gets.chomp
		if @more.split(".")[0].to_i > 0
			self.new_page(@more)
		end
		@one+=20
	end
    puts "\n\n\nCheck craigslist.com for more listings"
end



def new_page(id)
	listing = ApartmentCliGem::Listing.find_by_id(@more)
			if !listing.nil?
				page = ApartmentCliGem::ListingPage.new(@city, listing.path)
				page.show
			else
				puts "No listing found"
			end

end

end
