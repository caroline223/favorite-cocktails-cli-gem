class FavoriteCocktails::CLI

    BASE_URL = 'https://makemeacocktail.com/'

    def start 
        puts "------------------------"
        puts "   Famous Cocktails     ".light_green
        puts "  Care to take a sip??  ".light_blue
        puts "------------------------"
        drinks = create_cocktails
        @c = 0
        @f = 4
        name_cocktails(drinks)
    end

    def create_cocktails
        cocktails_array = FavoriteCocktails::Scraper.scrape_index(BASE_URL + "recipes/100+Cocktails/")
        cocktails_array.collect do |cocktails|
            FavoriteCocktails::Cocktails.new(cocktails[:name], cocktails[:page_url])
        end
    end


    def name_cocktails(drinks)
        puts ""
        drinks[@c..@c+@f].each_with_indnex(@c +1){|a,i| puts "[#{i}] #{a.name}"}
        puts "[all]" if  @f != 64
        puts "[previous]" if 
        puts "[next]" if @c == 0 && @f == 4
        puts "[previous || next]" if @c + @f >= 64 && @f == 4 
        puts ""
        puts "Type [exit] at any time to quit the search."
        puts ""
        puts "Type in the cocktail drink or number to learn more about the cocktail."
        input = gets.strip
        if input.to_i > 0 && input.to_i <= drinks.length
            cocktails_more_info(FavoriteCocktails::Cocktails.all[input.to_i - 1])
        elsif cocktails_more_info(FavoriteCocktails::Cocktails.all.detect{|cocktails| cocktails.name.downcase == input.downcase})
            cocktails_more_info(FavoriteCocktails::Cocktails.all.detect{|cocktails| cocktails.name.downcase == input.downcase})
        elsif input.downcase == "exit"
            self.exit
        else
            puts ""
            puts "Not quite. Please try again."
            self.name_cocktails(drinks)
        end

    end


    def cocktails_more_info(drinks)
        puts "FInd out more information about the #{cocktail.name}:"
        puts "(1) Description"
        puts "(2) Ingredients"
        puts "(3) Recipe"
        puts "(4) Return to the list of all cocktails"
        input = gets.strip
        subject = nil 
        info = nil 
        case = input.downcase
        when "1", "Description"
            subject = "Description"
            info = drinks.description 
        when "2", "Ingredients"
            subject = "Ingredients"
            info = drinks.ingredients  
        when "3", "Recipe"
            subject = "Recipe"
            info = drinks.recipe 
        when "exit" 
            exit 

        else
            puts "Whoa there! That's not a vaild input. Please try again."
        end

        cocktails_specific_info(drinks, subject, info)
    end

    def cocktails_specific_info(drinks, subject, info) #Presents more information to the user
        puts "------------------------"
        puts "------------------------"
        puts "#{drinks.name} ~ #{subject}".light_purple
        puts "------------------------"
        puts "------------------------"

        puts "(1) Discover more about the #{drinks.name}"
        puts "(2) Uncover a different cocktail."
        input = gets.strip
        case input.downcase
        when "1"
            cocktails_more_info(drinks)
        when "2"
            start 
        when "exit"
            exit
    
    else
        puts "Whoa there! That's not a vaild input. Please try again."
        cocktails_specific_info(drinks, subject, info)
    end
    end


    def exit #Upon leaving the program, give user a parting message
        puts "Thanks for visiting this page!"
        puts "Remember, stay thirsty my friends."
    end

end 