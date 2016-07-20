
class ApartmentCliGem::ListingPage

	attr_accessor :city, :path, :nested

	def initialize(city, path)
		@city = city
		@path = path
		@nested = Nokogiri::HTML(open("http://#{@city}.craigslist.org#{@path}"))
	end

	def show
		price = @nested.css('span.price').text
		sq_ft = @nested.css('span.housing').text
		title = @nested.css('span#titletextonly').text
		neighborhood = @nested.css('span.postingtitletext small').text
		description = @nested.css('section#postingbody').text
		puts "\n\n\n#{price} #{sq_ft} #{title} #{neighborhood}\n\n#{description}"
	end

end
