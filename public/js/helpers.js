function buildIngredient(ingredientName) {

  var ingredientTemplate = $.trim($('.ingredient-template').html());
  var $ingredient = $(ingredientTemplate);

  $ingredient.children("span").text(ingredientName);
  $ingredient.children("input").val(ingredientName)

  return $ingredient;
}

function buildRecipe(recipeObject){
  var recipeTemplate = $.trim($('.recipe-template').html());
  var $recipe = $(recipeTemplate);

  var image;
  if(!recipeObject.imageUrlsBySize){
    image = '/js/images/no_image.jpg'
  }
  else {
    image = recipeObject.imageUrlsBySize["90"];
  }

  var recipeName = recipeObject.recipeName;
  var id = recipeObject.id;

  $recipe.children("img").attr("src", image);
  $recipe.children("figcaption").text(recipeName);
  $recipe.attr("id", id);

  return $recipe;
}
