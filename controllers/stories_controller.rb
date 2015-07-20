# all stories for a user
get "/users/:id/stories" do
  @user = User.find(params["id"])
  @stories = User.find(params["id"]).stories
  erb :"/stories/index"
end

get "/stories/new" do
  if session["user_id"]
    if session["user_id"] == params["user_to_add_story_to"].to_i
      @user = User.find(session["user_id"])
      erb :"/stories/new"
    else
      "You're not logged in as the correct user"
    end
  else
    "You're not logged in"
  end
end

post "/users/:id/stories" do
  @story = Story.create({"name" => params["story"]["name"]})
  @user = User.find(params["id"])
  @user.stories << @story
  redirect "/users"
end

get "/stories/:story_id/edit" do
  if session["user_id"]
    if session["user_id"] == params["user_to_edit_story_of"].to_i
      @user = User.find(session["user_id"])
      @story = Story.find(params["story_id"])
      erb :"/stories/edit"
    else
      "You're not logged in as the correct user"
    end
  else
    "You're not logged in"
  end
end

put "/users/:id/stories/:story_id" do
  @story = Story.find(params["story_id"])
  @story.name = params["story"]["name"]
  @story.save
  redirect "/users"
end

delete "/stories/:story_id" do
  if session["user_id"]
    if session["user_id"] == params["user_to_delete_story_of"].to_i
      @story = Story.find(params["story_id"])
      @story.delete
      redirect "/users"
    else
      "You're not logged in as the correct user"
    end
  else
    "You must be signed in to do that."
  end
end

get "/stories/:id" do
  @story = Story.find(params["id"])
  erb :"/stories/show"
end