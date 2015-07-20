# all stories for a user
get "/users/:id/stories" do
  @user = User.find(params["id"])
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

get "/users/:id/stories/:story_id/edit" do
  @user = User.find(params["id"])
  @story = Story.find(params["story_id"])
  erb :"/stories/edit"
end

put "/users/:id/stories/:story_id" do
  @story = Story.find(params["story_id"])
  @story.name = params["story"]["name"]
  @story.save
  redirect "/users"
end