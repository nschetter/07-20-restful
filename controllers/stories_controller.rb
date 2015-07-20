# all stories for a user
get "/users/:id/stories" do
  @stories = User.find(params["id"]).stories
  erb :"/stories/index"
end

get "/users/:id/stories/new" do
  @user = User.find(params["id"])
  erb :"/stories/new"
end

post "/users/:id/stories" do
  @story = Story.create({"name" => params["story"]["name"]})
  @user = User.find(params["id"])
  @user.stories << @story
  redirect "/users"
end