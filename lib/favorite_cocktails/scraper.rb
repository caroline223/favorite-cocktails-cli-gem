require 'nokogiri'
require 'open-uri'
require 'pry'



class FavoriteCocktails::Scraper

   def self.scrape_index(url)
        url = 'https://www.townandcountrymag.com/leisure/drinks/g13092298/popular-bar-drinks-to-order/'

        favorite_cocktails = []
        doc = Nokogiri::HTML(open(url))
        drinks =  doc.css("div .listicle-slide-hed").text.gsub("\n"," ").gsub("\t","").strip
        drinks.each do |d|
            drink = {}
            drink[:name] = d.text 
            drink[:page_url] = d.attr("href")
            favorite_cocktails << drink
        end
        favorite_cocktails
    end

    
    def self.scrape_info(url)
        url = 'https://www.townandcountrymag.com/leisure/drinks/g13092298/popular-bar-drinks-to-order/'

        drink = {}
        doc = Nokogiri::HTML(open(url))
        drink[:description] = doc.css("div .listicle-slide-dek p:first-child").text.split(":")
        drink[:image] = doc.css("div span picture img").attr("src").value 
        drink[:ingredients] = doc.css("div p:nth-child(2)").text.split("-")
        drink[:instructions] = doc.css("div .listicle-slide-dek p em").text.split(".")
        drink
    end
        


end 