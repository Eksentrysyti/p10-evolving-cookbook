# RUN THIS CODE ONLY FOR HEROKU DEPLOYED VERSIONS
after do
  ActiveRecord::Base.connection.close
end
# ----------------------------------------

# ---------- LANDING PAGE ----------------

get '/' do

  erb :index
end

# ---------- SESSIONS --------------------

post '/sessions' do
  # sign-in, create session
  user = User.where(email: params[:email]).first
  if user && user.password == params[:password]
    session[:user_id] = user.id
    session[:user_name] = user.name

    redirect '/recipe_finder'
  else
    redirect '/'
  end
end

# routed from a link, changed to a non-restful get route
# delete '/sessions' do
get '/logout' do
  # sign-out -- invoked
  session[:user_id] = nil

  redirect '/'
end

# ---------- USERS -----------------------

post '/users' do
  # sign-up, create user
  user = User.create(name: params[:user][:name], email: params[:user][:email])
  user.password = params[:user][:password]
  user.save!
  session[:user_id] = user.id
  session[:user_name] = user.name
  
  redirect '/recipe_finder'
end

# ---------- RECIPEFINDER -------------------

get '/recipe_finder' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end

  erb :recipe_finder
end

# ---------- RECIPES --------------------

get '/recipes' do
  api = Yummly::Client.new(params)
  api.recipes
end

get '/get_recipe' do
  api = Yummly::Client.new(params)
  api.get_recipe
end

# ---------- FAVORITES ------------------

get '/favorites' do
  if session[:user_id]
    @favorites = User.find(session[:user_id]).recipes
  end
  
  erb :favorites
end

post '/favorites' do
  api = Yummly::Client.new(params)
  response = api.get_recipe
  User.find(session[:user_id]).recipes << Recipe.create(get_recipe_details(response))
  response
end


