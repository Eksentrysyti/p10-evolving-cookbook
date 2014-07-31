$(document).ready(function() {
	$('.add-ingredient').on('click', 'button', addIngredient);
	$('.delete-selected').on('click', deleteIngredients);
	$('.find-recipes').on('click', findRecipes)
});

function addIngredient(event){
	event.preventDefault();

  var ingredientName = $('.add-ingredient').children("input").val();
  $('.add-ingredient').children("input").val("");

  var ingredientElement = buildIngredient(ingredientName);
	$('.ingredient-list').append(ingredientElement);
}

function deleteIngredients(e){
	e.preventDefault();

  var $selectedIngredients = $('input[type="checkbox"]:checked')
  $selectedIngredients.parent().remove();
}

function findRecipes(event){
	event.preventDefault();

	var ingredientArray = []
  var $selectedIngredients = $('input[type="checkbox"]:checked')

	$selectedIngredients.each(function(i){
		ingredientArray.push($(this).val())
	})

}

// function findRecipesDOM(data){
// 	$.each($.parseJSON(data).matches, function(index, value){
// 		$('.recipe-container').append('<p>' + value.recipeName + '</p>')
// 	})
// }
