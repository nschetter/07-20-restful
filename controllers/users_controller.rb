# list users
get "/users" do
  @user = User.all
  
end

# new user
get "/users/new" do
  @new_user = User.new
  erb :"users/new"
end

# create user
post "/users" do
  name = params["user"]["name"]
  email = params["user"]["email"]
  prepassword = params["user"]["password"]
  password = BCrypt::Password.create(prepassword)
  @new_user = User.create({"name" => name, "email" => email, "password" => password})
  if @new_user.valid?
    redirect "/users/#{@new_user.id}"
  else
    erb :"/users/new"
  end
end

# delete user
delete "/users/:id" do
end

# edit user
get "/users/:id/edit" do
end

# update user
put "/users/:id" do
end

# show a user
get "/users/:id" do
end