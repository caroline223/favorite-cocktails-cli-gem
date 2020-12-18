lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "favorite_cocktails/version"

Gem::Specification.new do |spec|
  spec.name          = "favorite_cocktails"
  spec.version       = FavoriteCocktails::VERSION
  spec.authors       = ["caroline223"]
  spec.email         = ["carolineforrester22@gmail.com"]

  spec.summary       = "A gem that provides general information on different types of cocktails"
  spec.homepage      = "https://github.com/caroline223/favorite-cocktails-cli-gem"
  spec.license       = "MIT"


  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", ">= 0"
  spec.add_development_dependency "nokogiri", "~>1.10"
end
