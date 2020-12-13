require_relative "./favorite_cocktails/scraper.rb"
require_relative "./favorite_cocktails/cli.rb"
require_relative "./favorite_cocktails/cocktails.rb"

require "./favorite_cocktails/version"

require 'open-uri'
require 'nokogiri'
require 'pry'
  
module FavoriteCocktails
  class Error < StandardError; end
  # Your code goes here...
end
