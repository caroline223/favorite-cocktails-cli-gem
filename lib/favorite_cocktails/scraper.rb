require 'nokogiri'
require 'open-uri'
require 'pry'



class FavoriteCocktails::Scraper

   def self.scrape_index(url)
        url = 'https://www.townandcountrymag.com/leisure/drinks/g13092298/popular-bar-drinks-to-order/'
        doc = Nokogiri::HTML(URI.open(url))
        drinks = doc.css("div.listicle-slide")#.text.gsub("\n"," ").gsub("\t","").strip 
        drinks.map do |d|
            binding.pry  
            name = d.css("div.listicle-slide-hed").text.gsub(/[\n\t]/,"")
            page_url = d.css("div.listicle-slide-dek a").attr("href").value  
        end
    end
    
    def self.scrape_info(url)
        url = 'https://www.townandcountrymag.com/leisure/drinks/g13092298/popular-bar-drinks-to-order/'
        doc = Nokogiri::HTML(URI.open(url))
        description = doc.css("div .listicle-slide-dek p:first-child").text.split(":")
        image = doc.css("div span picture img").attr("src").value 
        ingredients = doc.css("div p:nth-child(2)").text.split("-")
        instructions = doc.css("div .listicle-slide-dek p em").text.split(".")
        drink
    end
        


end 