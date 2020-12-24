require 'lolize/auto'

class FavoriteCocktails::CLI

    BASE_URL = 'https://www.townandcountrymag.com'

    def start 
        puts "------------------------"
        puts "   Famous Cocktails     "
        puts "  Care to take a sip??  "
        puts "------------------------"
        cocktails = create_cocktails unless FavoriteCocktails::Cocktails.all.size > 0
        #binding.pry
        @c = 0
        @f = 10
        name_cocktails(cocktails)
    end

    def create_cocktails
         FavoriteCocktails::Scraper.scrape_index(BASE_URL + "/leisure/drinks/g13092298/popular-bar-drinks-to-order/")
    end

    def display_cocktails
        FavoriteCocktails::Cocktails.all[@c..@c+@f].each.with_index(@c +1) {|c,i| puts "[#{i}] #{c.name}"}
    end


    def name_cocktails(cocktails)
        display_cocktails
        puts ""
        puts "All" if  @c == 21
        puts "Previous" if @c + @f >= 11 && @c + @f < 21
        puts "Next" if @c > 0 && @c + @f < 11
        puts ""
        puts "Type [Exit] at any time to quit the search."
        puts ""
        puts "Type in the cocktail number to learn more about the cocktail."
        puts ""
        puts "Optional: Type [Next] to go to the next page, [Previous] to go to the previous page, or [All] to see all of the drinks."
        input = gets.strip
        if input.to_i > 0 && input.to_i <= cocktails.length
            cocktails_more_info(FavoriteCocktails::Cocktails.all[input.to_i - 1])
        elsif input.downcase == "all"
            @c = 0
            @f = 21
            name_cocktails(cocktails)
        elsif input.downcase == "previous"
            @c = 0
            @f = 10
            name_cocktails(cocktails)
        elsif input.downcase == "next"
            @c = 11
            @f = 21 
            name_cocktails(cocktails)
        elsif input.downcase == "exit"
            exit
        else
            puts ""
            puts "Not quite. Please try again."
            puts ""
            name_cocktails(cocktails)
        end
    end
    
    def cocktails_more_info(cocktails)
        #binding.pry
        #information = FavoriteCocktails::Scraper.scrape_info(cocktail)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   .add_information(information)
        puts ""
        puts "------------------------"
        puts "#{cocktails.name}:"
        puts "------------------------"
        puts "[1] Description"
        puts "[2] Ingredients"
        puts "[3] Instructions"
        puts "[4] Return to the list of all cocktails"
        input = gets.strip
        subject = nil 
        info = nil 
        case input.downcase
        when "1", "Description"
            subject = "Description"
            info = cocktails.description
            puts "------------------------"
            puts "#{cocktails.name}'s Description"
            puts "------------------------"
            puts ""
            puts "Did you know?"
            puts "#{cocktails.image}"
            puts "#{cocktails.description}"
        when "2","Ingredients"
            subject = "Ingredients"
            info = cocktails.ingredients 
            puts "------------------------"
            puts "#{cocktails.name}'s Ingredients"
            puts "------------------------"
            puts ""
            puts "#{cocktails.ingredients}"
        when "3","Instructions"
            subject = "Instructions"
            info = cocktails.ingredients 
            puts "------------------------"
            puts "How to make a #{cocktails.name}"
            puts "------------------------"
            puts ""
            puts "#{cocktails.instructions}"   
        when "4" 
            start
        else
            puts "Whoa there! That's not a vaild input. Please try again."
            cocktails_more_info(cocktails)
        end
        cocktails_specific_info(cocktails, info)
    end


    def cocktails_specific_info(cocktails, info) #Presents more information to the user
        puts ""
        puts "------------------------"
        puts "Learn more about #{cocktails.name}"
        puts "------------------------"
        puts ""

        puts "[1] Discover more about the #{cocktails.name}"
        puts "[2] Uncover a different cocktail."
        puts "[3] Exit the program."
        input = gets.strip
        case input.downcase
            when "1"
                cocktails_more_info(cocktails) 
            when "2"
                start
            when "3"
                exit
    
        else
            puts "Whoa there! That's not a vaild input. Please try again."
            cocktails_specific_info(cocktails, info)
        end
    
    end


    def exit 
        puts ""
        puts "Thanks for visiting this page!"
        puts ""
        puts " 00000000 "
        puts "  000000 "
        puts "   0000 "
        puts "    00 "
        puts "    || "
        puts "    || "
        puts "    || "
        puts "    || "
        puts " ________ "
        puts " -------- "
        puts ""
        puts "Remember, stay thirsty my friends :) ."
    end

end 