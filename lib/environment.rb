require_relative "./favorite_cocktails/version"
require_relative "./favorite_cocktails/scraper"
require_relative "./favorite_cocktails/cli"
require_relative "./favorite_cocktails/cocktails"

require 'open-uri'
require 'nokogiri'
require 'pry'
  
module FavoriteCocktails
  class Error < StandardError; end
  # Your code goes here...
end
