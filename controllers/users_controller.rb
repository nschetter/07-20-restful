set :sessions => true

# home
get "/" do
  redirect "/users"
end

# list users
get "/users" do
  @users = User.all
  erb :"users/index"
end

# new user
get "/users/new" do
  @user = User.new
  erb :"users/new"
end

# create user
post "/users" do
  name = params["user"]["name"]
  email = params["user"]["email"]
  prepassword = params["user"]["password"]
  password = BCrypt::Password.create(prepassword)
  @user = User.create({"name" => name, "email" => email, "password" => password})
  if @user.valid?
    redirect "/users/#{@user.id}"
  else
    erb :"/users/new"
  end
end

# delete user
delete "/users/:id" do
  @user = User.find(params["id"])
  if session["user_id"] == @user.id
    @user.delete
    redirect "/users"
  else
    "You can not delete. You must be signed in as this user."
  end
end

# edit user
get "/users/:id/edit" do
  @user = User.find(params["id"])
  if session["user_id"] == @user.id
    erb :"/users/edit"
  else
    "Fail"
  end
end

# update user
put "/users/:id" do
  @user = User.find(params["id"])
  @user.name = params["user"]["name"]
  @user.email = params["user"]["email"]
  if params["user"]["password"] != ""
    prepassword = params["user"]["password"]
    password = BCrypt::Password.create(prepassword)
    @user.password = password
  end
  @user.save
  redirect "/users"
end

get "/users/login" do
  erb :"/users/login"
end

get "/users/logout" do
  session["user_id"] = nil
  redirect "/users"
end

# show a user
get "/users/:id" do
  @user = User.find(params["id"])
  erb :"users/show"
end

post "/users/login" do
  user = User.find_by(email: params["email"])
  if BCrypt::Password.new(user.password) == params["password"]
    session["user_id"] = user.id
    redirect "/users"
  else
    erb :"/users/login"
  end
end
