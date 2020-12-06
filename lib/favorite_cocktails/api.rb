class API

    BASE_URL = "https://www.thecocktaildb.com/"

    def call
        url = BASE_URL + "/api/json/v1/1/search.php?f=a"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        formatted_response = JSON.parse(response)
        #resp_2 = HTTParty.get(url)
        formatted_response["drinks"] .each do |drink_hash|
            binding.pry
        end
    end

end 