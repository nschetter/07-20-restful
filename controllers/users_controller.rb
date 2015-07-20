# home
get "/" do
  @users = User.all
  erb :"home"
end

# list users
get "/users" do
  @user = User.all
  
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
  @user.delete
  redirect "/"
end

# edit user
get "/users/:id/edit" do
  @user = User.find(params["id"])
  erb :"/users/edit"
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
  redirect "/"
end

# show a user
get "/users/:id" do
end