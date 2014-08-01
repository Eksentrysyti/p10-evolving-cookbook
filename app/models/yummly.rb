module Yummly
  class Client
    include HTTParty

    base_uri "http://api.yummly.com/v1/"

    def initialize(params)
      @ingredient_names = params[:ingredient_names]
      @recipe_id = params[:recipe_id]
    end

    def recipes
      api_uri = "/api/recipes?_app_id=#{ENV['YUMMLY_APP_ID']}&_app_key=#{ENV['YUMMLY_API_KEY']}" + build_ingredient_string
      response = self.class.get(api_uri)
      response.body
    end

    def get_recipe
      api_uri = "/api/recipe/#{@recipe_id}?_app_id=#{ENV['YUMMLY_APP_ID']}&_app_key=#{ENV['YUMMLY_API_KEY']}"
      response = self.class.get(api_uri)
      response.body
    end

    def build_ingredient_string
      ingredient_string = ""
      @ingredient_names.each do |ingredient|
        ingredient_string += "&allowedIngredient[]=" + ingredient.gsub(" ", "+")
      end
      ingredient_string
    end

  end
end
