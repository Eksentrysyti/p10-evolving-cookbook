module Yummly

  class Client
    include HTTParty

    base_uri "http://api.yummly.com/v1/"

    def initialize(my_ingredients)
      @my_ingredients = my_ingredients
    end

    def recipes
      api_uri = "/api/recipes?_app_id=#{ENV['YUMMLY_APP_ID']}&_app_key=#{ENV['YUMMLY_APP_KEY']}" + @my_ingredients
      response = self.class.get(api_uri)
      response.body
    end

  end

end