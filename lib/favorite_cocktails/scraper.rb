require 'nokogiri'
require 'open-uri'
require 'pry'



class FavoriteCocktails::Scraper

    def self.scrape_index(url)
        url = 'https://makemeacocktail.com/recipes/100+Cocktails/'

        favorite_cocktails = []
        doc = Nokogiri::HTML(open(url))
        drinks = doc.css()
            binding.pry
        drinks.each do |d|
            drink = {}
            drink[:name] = d.text
            drink[:page_url] = d.attr("href")
            favorite_cocktails << drink
        end
        favorite_cocktails
    end

    
    #def self.scrape_drinks
        #page_url = 'https://makemeacocktail.com/recipes/100+Cocktails/'

        #drinks = Nokogiri::HTML(open(page_url))
        #cocktail_drinks = drinks.css("a")
        #cocktail_drinks.each do |cocktails|
                #hash = {
                #name: cocktails.css("h5").text.split, 
                #rating: cocktails.css() 
        #}        
        #end
        #binding.pry
        #cocktail_description = description.css()
        
        #FavoriteCocktails.new(cocktails)
    #end

end 