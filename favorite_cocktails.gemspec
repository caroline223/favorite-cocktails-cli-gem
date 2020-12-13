require_relative 'lib/favorite_cocktails/version'

Gem::Specification.new do |spec|
  spec.name          = "favorite_cocktails"
  spec.version       = FavoriteCocktails::VERSION
  spec.authors       = ["caroline223"]
  spec.email         = ["carolineforrester22@gmail.com"]

  spec.summary       = %q{A gem that provides information on many different types of cocktails}
  spec.homepage      = "https://github.com/caroline223/favorite_cocktails"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  spec.add_dependency "nokogiri" , '>= 1.8.5'

gem "rake", "~> 12.0"
gem "rspec", "~> 3.0"
gem "bundler"
gem "pry"

end
