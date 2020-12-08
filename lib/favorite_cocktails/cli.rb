class FavoriteCocktails::CLI

    BASE_URL = 'https://makemeacocktail.com/'

    def start
        puts "------------------------"
        puts "------------------------"
        puts "   Famous Cocktails     "
        puts "  Care to take a sip??  "
        puts "------------------------"
        puts "------------------------"
        drinks = create_cocktails

        name_cocktails(drinks)


    end

    def create_cocktails
        cocktails_array = FavoriteCocktails::Scraper.scrape_index(BASE_URL + "recipes/100+Cocktails/")
        cocktails_array.collect do |cocktails|
            FavoriteCocktails::Cocktails.new(cocktails[:name], cocktails[:page_url])
        end
    end


    def name_cocktails(drinks)
        puts
        puts
        puts
        puts
        puts
        puts "Type in the cocktail drink or number to learn more about the cocktail."
        input = gets.strip
        if input.to_i > 0 && input.to_i <= drinks.length
            cocktails_more_info(FavoriteCocktails::Cocktails.all[input.to_i - 1])
        elsif cocktails_more_info(FavoriteCocktails::Cocktails.all.detect{|cocktails| cocktails.name.downcase == input.downcase})
            cocktails_more_info(FavoriteCocktails::Cocktails.all.detect{|cocktails| cocktails.name.downcase == input.downcase})

    end


    def cocktails_more_info(drinks)
        puts
        puts "FInd out more information about the #{cocktail.name}:"
        puts "(1) Description"
        puts "(2) Ingredients"
        puts "(3) Recipe"
        puts "(4) Return to the list of all cocktails"
        input = gets.strip
    end

    def cocktails_specific_info(drinks, topic, info)
    end


    def exit #Upon leaving the program, give user a parting message
        puts "Thanks for visiting this page!"
        puts "Remember, stay quenched my friends."
    end

end 