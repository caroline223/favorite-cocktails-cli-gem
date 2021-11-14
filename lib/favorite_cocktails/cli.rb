require 'lolize/auto'

class FavoriteCocktails::CLI

    BASE_URL = 'https://www.townandcountrymag.com'

    def start 
        puts "------------------------"
        puts "   Famous Cocktails     "
        puts "  Care to take a sip??  "
        puts "------------------------"
        cocktail = create_cocktails unless FavoriteCocktails::Cocktail.all.size > 0
        @c = 0
        @f = 9
        name_cocktails(cocktail)
    end

    def create_cocktails
         FavoriteCocktails::Scraper.scrape_index(BASE_URL + "/leisure/drinks/g13092298/popular-bar-drinks-to-order/")
    end

    def display_cocktails
        FavoriteCocktails::Cocktail.all[@c..@c+@f].each.with_index(@c +1) {|c,i| puts "[#{i}] #{c.name}"}
    end

    def name_cocktails(cocktail)
        display_cocktails
        puts ""
        puts ""
        puts "Type [Exit] at any time to quit the search."
        puts ""
        puts "Type in the cocktail name or number to learn more about the cocktail."
        puts ""
        puts "Optional: Type [Next] to go to the next page, [Previous] to go to the previous page, or [All] to see all of the drinks."
        input = gets.strip
        if input.to_i > 0 && input.to_i <= 22
            cocktails_more_info(FavoriteCocktails::Cocktail.all[input.to_i - 1])
        elsif FavoriteCocktails::Cocktail.all.detect{|cocktail| cocktail.name.downcase == input.downcase}
                cocktails_more_info(FavoriteCocktails::Cocktail.all.detect{|cocktail| cocktail.name.downcase == input.downcase})
        elsif input.downcase == "all"
            @c = 0
            @f = 21
            name_cocktails(cocktail)
        elsif input.downcase == "previous"
            @c -= 10 unless @c == 0 
            name_cocktails(cocktail)
        elsif input.downcase == "next"
                @c += 10 unless @c + @f >= 21
            name_cocktails(cocktail)
        elsif input.downcase == "exit"
            exit
        else
            puts ""
            puts "Not quite. Please try again."
            puts ""
            name_cocktails(cocktail)
        end
    end
    
    def cocktails_more_info(cocktail)
        puts ""
        puts "------------------------"
        puts "Learn more about #{cocktail.name}:"
        puts "------------------------"
        puts ""
        puts "Please select a number corresponding to what you would like to learn more about."
        puts ""
        puts ""
        puts "[1] Description"
        puts "[2] Ingredients"
        puts "[3] Instructions"
        puts "[4] Return to the list of all cocktails"
        puts "[5] Exit the program. "
        input = gets.strip
        subject = nil 
        info = nil 
        case input.downcase
        when "1"
            subject = "Description"
            info = cocktail.description
            puts "------------------------"
            puts "#{cocktail.name}'s Description"
            puts "------------------------"
            puts ""
            puts "Did you know?"
            puts ""
            puts "Image : #{cocktail.image}"
            puts ""
            puts "#{cocktail.description}"
            cocktails_specific_info(cocktail)
        when "2"
            subject = "Ingredients"
            info = cocktail.ingredients 
            puts "------------------------"
            puts "#{cocktail.name}'s Ingredients"
            puts "------------------------"
            puts ""
            puts "#{cocktail.ingredients}"
            cocktails_specific_info(cocktail)
        when "3"
            subject = "Instructions"
            info = cocktail.instructions 
            puts "------------------------"
            puts "How to make a #{cocktail.name}"
            puts "------------------------"
            puts ""
            puts "#{cocktail.instructions}"  
            cocktails_specific_info(cocktail) 
        when "4" 
            start
        when "5" 
            exit
        when "exit"
            exit
       
        else
            puts "Whoa there! That's not a vaild input. Please try again."
            cocktails_more_info(cocktail)
        end
    end


    def cocktails_specific_info(cocktail) 
        puts ""
        puts "------------------------"
        puts "Learn more about #{cocktail.name}"
        puts "------------------------"
        puts ""
        puts "Please select a number corresponding to what you would like to learn further."
        puts ""
        puts ""

        puts "[1] Discover more about the #{cocktail.name}"
        puts "[2] Uncover a different cocktail."
        puts "[3] Exit the program."
        input = gets.strip
        case input.downcase
        when "1"
                cocktails_more_info(cocktail) 
        when "2"
                start
        when "3" 
            exit
        when "exit"
            exit
    
        else
            puts "Whoa there! That's not a vaild input. Please try again."
            cocktails_specific_info(cocktail)
        end
    
    end

    def exit 
        puts ""
        puts "Thanks for visiting this page!"
        puts ""
        puts " 00000000   "
        puts "  000000    "
        puts "   0000     "
        puts "    00      "
        puts "    ||      "
        puts "    ||      "
        puts "    ||      "
        puts "    ||      "
        puts " ________   "
        puts " --------   "
        puts ""
        puts "Remember, stay thirsty my friends :) ."
    end

end 