$(document).ready(function() {
  bindListeners();
});

function bindListeners(){
  $('.add-ingredient').on('click', 'button', addIngredient);
  $('.delete-selected').on('click', deleteIngredients);
  $('.find-recipes').on('click', findRecipes);
  $('.recipe-list').on('click', 'img', getRecipe);
  $('.recipe-list').on('click', 'button', addFavoriteRecipe)
}

// ---------------- INGREDIENTS --------------------------
function addIngredient(e){
  e.preventDefault();

  var ingredientName = $('.add-ingredient').children("input").val();
  $('.add-ingredient').children("input").val("");

  var ingredientElement = buildIngredient(ingredientName);
  $('.ingredient-list').append(ingredientElement);
}

function deleteIngredients(e){
  e.preventDefault();

  var $selectedIngredients = $('input[type="checkbox"]:checked:visible')
  $selectedIngredients.parent().remove();
}

// --------------- RECIPES AJAX TO API--------------------

function findRecipes(e){
  e.preventDefault();

  var ingredientArray = [];
  var $selectedIngredients = $('input[type="checkbox"]:checked:visible');

  $selectedIngredients.each(function(i){
    ingredientArray.push($(this).val());
  })
  var request = $.ajax({
    url: '/recipes',
    type: 'GET',
    data: { ingredient_names: ingredientArray }
  }).done(drawRecipesDOM);
}

function drawRecipesDOM(data){

  var $responseObject = $.parseJSON(data);
  var matchCount = $responseObject.totalMatchCount;

  $('.recipe-list').empty();

  $.each($responseObject.matches, function(index,value){
    $('.recipe-list').append(buildRecipe(value))
  });
}

function getRecipe(e){
  e.preventDefault();

  var recipeId = $(this).parent().attr("id");

  var request = $.ajax({
    url: '/get_recipe',
    type: 'GET',
    data: { recipe_id: recipeId}
  }).done(linkToRecipe);
}

function linkToRecipe(data){
  var $responseObject = $.parseJSON(data);
  var recipeURL = $responseObject.source.sourceRecipeUrl;

  window.open(recipeURL);
}

// --------------- FAVORITES --------------------

function addFavoriteRecipe(){
  var recipeId = $(this).parent().attr("id")

  $(this).prop("disabled", true).text("Favorited!")

  var request = $.ajax({
    url: '/favorites',
    type: 'POST',
    data: { recipe_id: recipeId}
  }).done();
}

