require 'nokogiri'
require 'open-uri'
require 'pry'



class FavoriteCocktails::Scraper

   def self.scrape_index(url)
        url = 'https://www.townandcountrymag.com/leisure/drinks/g13092298/popular-bar-drinks-to-order/'
        doc = Nokogiri::HTML(URI.open(url))
        drinks = doc.css("div.listicle-slide")#.text.gsub("\n"," ").gsub("\t","").strip 
        drinks.map do |d|
            #binding.pry 
            page_url = nil  
            name = d.css("div.listicle-slide-hed").text.gsub(/[\n\t]/,"")
            if d.css("div.listicle-slide-dek p:nth-child(4) a").attr("href")
                page_url = d.css("div.listicle-slide-dek p:nth-child(4) a").attr("href").value 
            end 
            FavoriteCocktails::Cocktails.new(name, page_url)
        end
    end
    
    def self.scrape_info(cocktail)
        doc = Nokogiri::HTML(URI.open(cocktail.page_url))
        binding.pry
        description = doc.css("div.listicle-slide-dek p:first-child").text.split(":")
        cocktail.image = #doc.css("div span picture img").attr("src").value 
        cocktail.ingredients = #doc.css("div p:nth-child(2)").text.split("-")
        cocktail.instructions = #doc.css("div.listicle-slide-dek p em").text.split(".")
    end
        

end 