class FavoriteCocktails::CLI

    BASE_URL = 'https://www.townandcountrymag.com'

    def start 
        puts "------------------------"
        puts "   Famous Cocktails     "
        puts "  Care to take a sip??  "
        puts "------------------------"
        cocktail = create_cocktails unless FavoriteCocktails::Cocktails.all.size > 0
        #binding.pry
        @c = 0
        @f = 11
        name_cocktails(cocktail)
    end

    def create_cocktails
         FavoriteCocktails::Scraper.scrape_index(BASE_URL + "/leisure/drinks/g13092298/popular-bar-drinks-to-order/")
    end


    def name_cocktails(cocktail)
        puts ""
        cocktail[@c..@c+@f].each.with_index(@c +1){|d,i| puts "[#{i}] #{d.name}"}
        puts "All" if  @c != 21
        puts "Previous" if @c + @f >= 12 
        puts "Next" if @c == 0 
        puts ""
        puts "Type [Exit] at any time to quit the search."
        puts ""
        puts "Type in the cocktail number to learn more about the cocktail."
        puts "Optional: Type [Next] to go to the next page, or [All] to see all of the drinks."
        input = gets.strip
        if input.to_i > 0 && input.to_i <= cocktail.length
            cocktails_more_info(FavoriteCocktails::Cocktails.all[input.to_i - 1])
        elsif input.downcase == "all"
            @f = 21
            name_cocktails(cocktail)
        elsif input.downcase == "previous"
            @c = 0
            name_cocktails(cocktail)
        elsif input.downcase == "next"
            @c += 11
            name_cocktails(cocktail)
        elsif input.downcase == "exit"
            exit
        else
            puts ""
            puts "Not quite. Please try again."
            name_cocktails(cocktail)
        end
    end

    
    def cocktails_more_info(cocktail)
        #binding.pry
        #information = FavoriteCocktails::Scraper.scrape_info(cocktail)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   .add_information(information)
        puts "#{cocktail.name}:"
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
            info = cocktail.description
            puts "------------------------"
            puts "Description of the #{cocktail.name}"
            puts "------------------------"
            puts ""
            puts "Did you know?"
            puts "#{cocktail.image}"
            puts "#{cocktail.description}"
        when "2","Ingredients"
            subject = "Ingredients"
            info = cocktail.ingredients 
            puts "------------------------"
            puts "#{cocktail.name}'s Ingredients"
            puts "------------------------"
            puts ""
            puts "#{cocktail.ingredients}"
        when "3","Instructions"
            subject = "Instructions"
            info = cocktail.ingredients 
            puts "------------------------"
            puts "How to make a #{cocktail.name}"
            puts "------------------------"
            puts ""
            puts "#{cocktail.instructions}"   
        when "4" 
            name_cocktails(cocktail)
        else
            puts "Whoa there! That's not a vaild input. Please try again."
            cocktails_more_info(cocktail)
        end
        cocktails_specific_info(cocktail, subject, info)
    end


    def cocktails_specific_info(cocktail, subject, info) #Presents more information to the user
        puts " "
        puts "------------------------"
        puts "Learn more about #{cocktail.name}"
        puts "------------------------"
        puts " "

        puts "[1] Discover more about the #{cocktail.name}"
        puts "[2] Uncover a different cocktail."
        puts "[3] Exit the program."
        input = gets.strip
        case input.downcase
            when "1"
                cocktails_more_info(cocktail) 
            when "2"
                name_cocktails(cocktail) 
            when "3"
                exit
    
        else
            puts "Whoa there! That's not a vaild input. Please try again."
            cocktails_more_info(cocktail, subject, info)
        end
    
    end


    def exit 
        puts "Thanks for visiting this page!"
        puts "Remember, stay thirsty my friends :) ."
    end

end 