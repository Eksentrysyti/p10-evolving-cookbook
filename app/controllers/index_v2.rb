# RUN THIS CODE ONLY FOR HEROKU DEPLOYED VERSIONS
# after do
#   ActiveRecord::Base.connection.close
# end
# ----------------------------------------

# ---------- LANDING PAGE ----------------

get '/' do

  erb :index
end

# ---------- SESSIONS --------------------

post '/sessions' do
  # sign-in, create session
  user = User.where(email: params[:email]).first
  if user.password == params[:password]
    session[:user_id] = user.id
  end

  redirect '/cookbook'
end

# delete '/sessions' do
get '/logout' do
  # sign-out -- invoked
  session[:user_id] = nil

  redirect '/'
end

# ---------- USERS -----------------------

post '/users' do
  # sign-up, create user
  @user = User.create(name: params[:user][:name], email: params[:user][:email])
  @user.password = params[:user][:password]
  @user.save!

  redirect '/'
end

# ---------- COOKBOOK -------------------

get '/cookbook' do
  if session[:user_id]
    @user = User.find(session[:user_id])
  end

  erb :cookbook
end
