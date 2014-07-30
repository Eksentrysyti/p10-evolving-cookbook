module Yummly

  class Client
    include HTTParty

    base_uri "http://api.yummly.com/v1/"

    def initialize(my_ingredients)
      @my_ingredients = my_ingredients
    end

    def recipes
      api_uri = "/api/recipes?_app_id=281eb528&_app_key=647a87ea8f496209b18fdd54a2088627" + @my_ingredients
      response = self.class.get(api_uri)
      response.body
    end

  end

end