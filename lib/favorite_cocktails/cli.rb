class FavoriteCocktails::CLI

    BASE_URL = 'https://www.townandcountrymag.com'

    def start 
        puts "------------------------"
        puts "   Famous Cocktails     "
        puts "  Care to take a sip??  "
        puts "------------------------"
        drinks = create_cocktails
        #binding.pry
        @c = 0
        @f = 11
        name_cocktails(drinks)
    end

    def create_cocktails
         FavoriteCocktails::Scraper.scrape_index(BASE_URL + "/leisure/drinks/g13092298/popular-bar-drinks-to-order/")
    end


    def name_cocktails(drinks)
        puts ""
        drinks[@c..@c+@f].each.with_index(@c +1){|d,i| puts "[#{i}] #{d.name}"}
        puts "all" if  @c != 21
        puts "previous" if @c + @f >= 11 
        puts "next" if @c == 0 
        #puts "previous || next" if @c + @f < 19 && @c >= 10 
        puts ""
        puts "Type (exit) at any time to quit the search."
        puts ""
        puts "Type in the cocktail drink or number to learn more about the cocktail."
        input = gets.strip
        if input.to_i > 0 && input.to_i <= drinks.length
            cocktails_more_info(FavoriteCocktails::Cocktails.all[input.to_i - 1])
        #elsif cocktails_more_info(FavoriteCocktails::Cocktails.all.detect{|drink| drink.name.downcase == input.downcase})
            #cocktails_more_info(FavoriteCocktails::Cocktails.all.detect{|drink| drink.name.downcase == input.downcase})
        elsif input.downcase == "all"
            @c = 21
            name_cocktails(drinks)
        elsif input.downcase == "previous"
            @c = 0
            name_cocktails(drinks)
        elsif input.downcase == "next"
            @c += 11
            name_cocktails(drinks)
        elsif input.downcase == "previous" && @c == 0
            puts "That's all of the drinks!"
            name_cocktails(drinks)
        elsif input.downcase == "next" && @c == 11
            puts "You've seen all of the drinks! You must of been really thirsty :)"
            name_cocktails(drinks)
        else
            puts ""
            puts "Not quite. Please try again."
            name_cocktails(drinks)
        end

    end

    
    def cocktails_more_info(drink)
        #binding.pry
        information = FavoriteCocktails::Scraper.scrape_info(drink)
        drink.add_information(information)
        puts "FInd out more information about the #{drink.name}:"
        puts "(1) Description"
        puts "(2) Ingredients"
        puts "(3) Instructions"
        puts "(4) Return to the list of all cocktails"
        input = gets.strip
        subject = nil 
        info = nil 
        case input.downcase
        when "1", "Description"
            subject = "Description"
            info = drink.description
            puts "------------------------"
            puts "Description of the #{drink.name}"
            puts "------------------------"
            puts ""
            puts "Did you know?"
            puts "#{drink.image}"
            puts "#{drink.description}"
        when "2","Ingredients"
            subject = "Ingredients"
            info = drink.ingredients 
            puts "------------------------"
            puts "#{drink.name}'s ingredients'"
            puts "------------------------"
            puts ""
            puts "#{drink.ingredients}"
        when "3","Instructions"
            subject = "Instructions"
            info = drink.ingredients 
            puts "------------------------"
            puts "How to make #{drink.name}"
            puts "------------------------"
            puts ""
            puts "#{drink.instructions}"   
        when "4" 
            exit 

        else
            puts "Whoa there! That's not a vaild input. Please try again."
            cocktails_more_info(drink)
        end

        cocktails_specific_info(drink, subject, info)
    end


    def cocktails_specific_info(drink, subject, info) #Presents more information to the user
        puts "------------------------"
        puts "------------------------"
        puts "#{drink.name} ~ #{subject}"
        puts "------------------------"
        puts "------------------------"

        puts "(1) Discover more about the #{drink.name}"
        puts "(2) Uncover a different cocktail."
        puts "(3) Return to main menu"
        input = gets.strip
        case input.downcase
            when "1"
                cocktails_more_info(drinks) 
            when "2"
                start 
            when "3"
                exit
    
        else
            puts "Whoa there! That's not a vaild input. Please try again."
            cocktails_more_info(drink, subject,info)
        end
    
    end


    def exit #Upon leaving the program, give user a parting message
        puts "Thanks for visiting this page!"
        puts "Remember, stay thirsty my friends."
    end

end 