require 'nokogiri'
require 'open-uri'
require 'pry'


class Scraper

    BASE_URL = "https://liquor.com/"

    def self.scrape_drinks
        page_url = 'https://www.liquor.com/popular-cocktails-4845950'
        cocktails_array = []

        drinks = Nokogiri::HTML(open(page_url))
        cocktail_drinks = drinks.css("h2")
        cocktail_drinks.each do |cocktails|
            binding.pry
            hash = {
                title: cocktails.css("a").text ,
                description: 
            }
            
        end
        Cocktails.new(cocktails_hash)

    end

end 