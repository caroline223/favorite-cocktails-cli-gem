class FavoriteCocktails::CLI

    BASE_URL = 'https://www.townandcountrymag.com'

    def start 
        puts "------------------------"
        puts "   Famous Cocktails     ".light_green
        puts "  Care to take a sip??  ".light_blue
        puts "------------------------"
        drinks = create_cocktails
        @c = 0
        @f = 1
        name_cocktails(drinks)
    end

    def create_cocktails
        drinks_array = FavoriteCocktails::Scraper.scrape_index(BASE_URL + "/leisure/drinks/g13092298/popular-bar-drinks-to-order/")
        drinks_array.collect do |drink|
            FavoriteCocktails::Cocktails.new(drink[:name], drink[:page_url])
        end
    end


    def name_cocktails(drinks)
        puts ""
        drinks[@c..@c+@f].each_with_index(@c +1){|d,i| puts "[#{i}] #{d.name}"}
        puts "(all)" if  @f != 19
        puts "(previous)" if @c + @f >= 19 && @f == 1
        puts "(next)" if @c == 0 && @f == 1
        puts "(previous || next)" if @c + @f < 19 && @c >= 10 
        puts ""
        puts "Type (exit) at any time to quit the search."
        puts ""
        puts "Type in the cocktail drink or number to learn more about the cocktail."
        input = gets.strip
        if input.to_i > 0 && input.to_i <= drinks.length
            cocktails_more_info(FavoriteCocktails::Cocktails.all[input.to_i - 1])
        elsif cocktails_more_info(FavoriteCocktails::Cocktails.all.detect{|drink| drink.name.downcase == input.downcase})
            cocktails_more_info(FavoriteCocktails::Cocktails.all.detect{|drink| drink.name.downcase == input.downcase})
        elsif input.downcase == "all"
            @c = 0
            @f = 19
            name_cocktails(drinks)
        elsif input.downcase == "previous"
            @c -= 10
            name_cocktails(drinks)
        elsif input.downcase == "next"
            @c += 10
            name_cocktails(drinks)
        elsif input.downcase == "previous" && @c == 0
            puts "That's all of the drinks!"
            name_cocktails(drinks)
        elsif input.downcase == "next" && @c+@f == 19
            puts "You've seen all of the drinks! You must of been really thirsty :)"
            name_cocktails(drinks)
        else
            puts ""
            puts "Not quite. Please try again."
            self.name_cocktails(drinks)
        end

    end

    
    def cocktails_more_info(drink)
        information = FavoriteCocktails::Scraper.scrape_info(BASE_URL + drink.page_url)
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
            puts "Description of the #{drink.name}".light_purple
            puts "------------------------"
            puts ""
            puts "Did you know?"
            puts "#{drink.image}"
            puts "#{drink.description}"
        when "2","Ingredients"
            subject = "Ingredients"
            info = drink.ingredients 
            puts "------------------------"
            puts "#{drink.name}'s ingredients'".light_purple
            puts "------------------------"
            puts ""
            puts "#{drink.ingredients}"
        when "3","Instructions"
            subject = "Instructions"
            info = drink.ingredients 
            puts "------------------------"
            puts "How to make #{drink.name}".light_purple
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
        puts "#{drink.name} ~ #{subject}".light_purple
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