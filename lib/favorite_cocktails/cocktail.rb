class FavoriteCocktails::Cocktail

    attr_accessor :name, :ingredients, :instructions, :description, :page_url, :image

    @@all = []

    def initialize(name, page_url, image, description, ingredients, instructions)
        self.name = name
        self.page_url = page_url
        self.image = image
        self.description = description
        self.ingredients = ingredients
        self.instructions = instructions
        save 
    end

   def save
    self.class.all << self
   end

   def self.all
    @@all
   end


end
