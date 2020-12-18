class FavoriteCocktails::Cocktails

    attr_accessor :name, :ingredients, :instructions, :description, :page_url 

    @@all = []

    def initialize(name, page_url)
        @name = name
        @page_url = page_url
        save 
    end

   def add_information(information)
       information.each do |key, value|
        self.send("#{key}=", value)
       end
   end

   def save
    self.class.all << self
   end

   def self.all
    @@all
   end

end