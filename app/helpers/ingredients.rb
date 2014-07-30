helpers do 

	def my_ingredients
		# Gets user's stored ingredients and puts their names in an array
		ingredient_array = []
		ingredient_objects = User.find(session[:user_id]).ingredients
		
		ingredient_objects.each do |ingredient|
			ingredient_array << ingredient.name
		end

		url_convert(ingredient_array)
	end

	def url_convert(ingredient_array)
		# Converts ingredient name array into a string for API call
		ingredient_string = ""

		ingredient_array.each do |ingredient|
			ingredient_string += "&allowedIngredient[]=" + ingredient.gsub(" ", "+")
		end

		ingredient_string
	end

end