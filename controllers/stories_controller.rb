# all stories for a user
get "/users/:id/stories" do
  @user = User.find(params["id"])
  @stories = User.find(params["id"]).stories
  erb :"/stories/index"
end


get "/users/:id/stories/new" do
  @user = User.find(params["id"])
  if session["user_id"] == @user.id
    erb :"/stories/new"
  else
    "You must be signed in to do that."
  end
end

post "/users/:id/stories" do
  @story = Story.create({"name" => params["story"]["name"]})
  @user = User.find(params["id"])
  @user.stories << @story
  redirect "/users"
end

get "/users/:id/stories/:story_id/edit" do
  @user = User.find(params["id"])
  if session["user_id"] == @user.id
    @story = Story.find(params["story_id"])
    erb :"/stories/edit"
  else
    "You must be signed in to do that."
  end
end

put "/users/:id/stories/:story_id" do
  @story = Story.find(params["story_id"])
  @story.name = params["story"]["name"]
  @story.save
  redirect "/users"
end

delete "/users/:id/stories/:story_id" do
  @story = Story.find(params["story_id"])
  if session["user_id"] == @user.id
    @story.delete
    redirect :"/users"
  else
    "You must be signed in to do that."
  end
end

get "/stories/:id" do
  @story = Story.find(params["id"])
  erb :"/stories/show"
end