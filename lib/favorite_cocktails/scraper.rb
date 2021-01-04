require 'nokogiri'
require 'open-uri'
require 'pry'



class FavoriteCocktails::Scraper

   def self.scrape_index(url)
        url = 'https://www.townandcountrymag.com/leisure/drinks/g13092298/popular-bar-drinks-to-order/'
        doc = Nokogiri::HTML(URI.open(url))
        cocktail = doc.css("div.listicle-slide")
        cocktail.map do |d|
            page_url = nil  
            name = d.css("div.listicle-slide-hed").text.gsub(/[\n\t]/,"")
            if image = d.css("img").attr("data-src")
                 d.css("img").attr("data-src").value
            else image = d.css("img").attr("src").value
            end
            description = d.css("div.listicle-slide-dek p:first-child").text.split(":").join(". ")
            ingredients = d.css("div.listicle-slide-dek p:nth-child(2)").text.strip 
            instructions = d.css("div.listicle-slide-dek p:nth-child(3) em").text
            if d.css("div.listicle-slide-dek p:nth-child(4) a").attr("href")
                page_url = d.css("div.listicle-slide-dek p:nth-child(4) a").attr("href").value 
            end 
            FavoriteCocktails::Cocktails.new(name, page_url, image, description, ingredients, instructions)
        end
    end
    
end 