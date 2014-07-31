function buildIngredient(ingredientName) {

  var ingredientTemplate = $.trim($('.ingredient-template').html());
  var $ingredient = $(ingredientTemplate);

  $ingredient.children("span").text(ingredientName);
  $ingredient.children("input").val(ingredientName)

  return $ingredient;
}
