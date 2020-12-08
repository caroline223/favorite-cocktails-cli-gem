require 'nokogiri'
require 'open-uri'
require 'pry'



class Scraper

    BASE_URL = "https://makemeacocktail.com/"

    def self.scrape_drinks
        page_url = 'https://makemeacocktail.com/recipes/100+Cocktails/'

        drinks = Nokogiri::HTML(open(page_url))
        cocktail_drinks = drinks.css("a")
        cocktail_drinks.each do |cocktails|
                cocktails.css("h5").text.split          
        end
        binding.pry
        cocktail_description = description.css()
        
        Cocktails.new(cocktails)
    end

end 