helpers do

  def get_recipe_details(api_response)
    p recipe_hash = JSON.parse(api_response)
    recipe_details = {
      name: recipe_hash["name"],
      source_url: recipe_hash["source"]["sourceRecipeUrl"],
      large_image_url: recipe_hash["images"][0]["hostedLargeUrl"],
      ingredient_list: recipe_hash["ingredientLines"]
    }
    recipe_details
  end

end
