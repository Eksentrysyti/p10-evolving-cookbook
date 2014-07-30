$(document).ready(function() {
	$('.add-ingredient').on('click', addIngredient);
	$('.ingredient-list').on('click', "a", deleteIngredient);
	$('.find-recipes').on('click', findRecipes)
});

function addIngredient(event){
	event.preventDefault();

	var newIngredient = $('#new-ingredient').val();
	$('#new-ingredient').val("");

	var userId = parseInt($('div.user-id').attr("value"));

	var request = $.ajax({
		url: '/ingredients', 
		type: 'POST',
		data: {	ingredient_name: newIngredient }
	}).done(addIngredientDOM);
}

function addIngredientDOM(data){
	var ingredientName = JSON.parse(data).ingredient_name;
	var ingredientItem = buildIngredient(ingredientName);

	$('.ingredient-list').append(ingredientItem);
}

function deleteIngredient(event){
	event.preventDefault();

	var ingredientName = $(this).closest("li").attr("id");
	var request = $.ajax({
		url: '/ingredients',
		type: 'DELETE',
		data: { ingredient_name: ingredientName }
	}).done(deleteIngredientDOM);
}

function deleteIngredientDOM(data){
	var ingredientName = JSON.parse(data).ingredient_name;
	$("li#"+ingredientName).remove();
}

function findRecipes(event){
	event.preventDefault();

	var request = $.ajax({
		url: 'recipes', 
		type: 'GET'
	}).done(findRecipesDOM)
}

function findRecipesDOM(data){
	$.each($.parseJSON(data).matches, function(index, value){
		$('.recipe-container').append('<p>' + value.recipeName + '</p>')
	})
}