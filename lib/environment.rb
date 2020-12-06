require_relative "favorite_cocktails/version"
require_relative "./favorite_cocktails/api"
require_relative "./favorite_cocktails/cli"
require_relative "./favorite_cocktails/cocktails"

require "httparty"
require "net/http"
require "pry"

module FavoriteCocktails
  class Error < StandardError; end
  # Your code goes here...
end
