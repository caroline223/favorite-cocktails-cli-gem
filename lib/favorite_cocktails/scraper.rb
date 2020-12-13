require 'nokogiri'
require 'open-uri'
require 'pry'



class FavoriteCocktails::Scraper

    def self.scrape_index(url)
        url = 'https://www.webstaurantstore.com/11/bar-drink-mixes.html'

        favorite_cocktails = []
        doc = Nokogiri::HTML(open(url))
        drinks = doc.css(".details a").text.split("plus")
        drinks.each do |d|
            drink = {}
            drink[:name] = d.text
            drink[:page_url] = d.attr("href")
            favorite_cocktails << drink
        end
        favorite_cocktails
    end

    
    def self.scrape_drinks(url)

        url = 'https://makemeacocktail.com/recipes/100+Cocktails/'
        drink = {}
        doc = Nokogiri::HTML(open(url))
        drink[:]




        drink
    end

end 