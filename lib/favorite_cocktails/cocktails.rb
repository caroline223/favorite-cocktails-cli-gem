class Cocktails

    @@all = []

   def initialize(cocktails_hash)
       cocktails_hash.each do |key, value|
        self.class.attr_accessor key
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