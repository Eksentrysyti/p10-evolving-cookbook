# RUN THIS CODE ONLY FOR HEROKU DEPLOYED VERSIONS
# after do
#   ActiveRecord::Base.connection.close
# end
# -----------------------------------------------

get '/' do
  if session[:user_id]
 	  @user = User.find(session[:user_id])
    @ingredients = @user.ingredients
  end

  erb :index
end

#----------- SESSIONS -----------

get '/sessions/new' do
  # render sign-in page 
	erb :sign_in
end

post '/sessions' do
  # sign-in, create session
  @user = User.where(email: params[:email]).first
  p @user
  if @user.password == params[:password]
  	session[:user_id] = @user.id
  end
  redirect '/'
end

delete '/sessions/:id' do
  # sign-out -- invoked
  session[:user_id] = nil
  redirect '/'
end

#----------- USERS ------------

get '/users/new' do
  erb :sign_up
end

post '/users' do
  @user = User.create(name: params[:user][:name], email: params[:user][:email])
  @user.password = params[:user][:password]
  @user.save!

  redirect '/'
end

#---------- INGREDIENTS -------

post '/ingredients' do
  user = User.find(session[:user_id])
  ingredient = Ingredient.new(name: params[:ingredient_name])
  user.ingredients << ingredient
  {ingredient_name: params[:ingredient_name]}.to_json
end

delete '/ingredients' do
  user = User.find(session[:user_id])
  ingredient = user.ingredients.where(name: params[:ingredient_name]).first
  ingredient.destroy
  {ingredient_name: params[:ingredient_name]}.to_json
end

#---------- RECIPES ----------

get '/recipes' do
  api = Yummly::Client.new(my_ingredients)
  p api.recipes
end