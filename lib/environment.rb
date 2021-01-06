require 'open-uri'
require 'nokogiri'
require 'pry'
require 'colorize'
require 'lolize'


require_relative "./favorite_cocktails/scraper.rb"
require_relative "./favorite_cocktails/cli.rb"
require_relative "./favorite_cocktails/cocktail.rb"

require_relative "./favorite_cocktails/version"


  
module FavoriteCocktails
  class Error < StandardError; end
  # Your code goes here...
end
