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
            image = d.css("span picture img").attr("src").value if d.css("span picture img").attr("src")
            description = d.css("div.listicle-slide-dek p:first-child").text.split(":").join(". ")
            ingredients = d.css("div.listicle-slide-dek p:nth-child(2)").text.split("-").delete_if {|string| string.empty?}
            instructions = d.css("div.listicle-slide-dek p:nth-child(3) em").text.split(".").delete_if {|string| string.empty? || string == " "}
            if d.css("div.listicle-slide-dek p:nth-child(4) a").attr("href")
                page_url = d.css("div.listicle-slide-dek p:nth-child(4) a").attr("href").value 
            end 
            FavoriteCocktails::Cocktails.new(name, page_url, image, description, ingredients, instructions)
        end
        #binding.pry
    end
    
end 