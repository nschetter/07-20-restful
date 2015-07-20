get "/users/:id/stories" do
  @stories = User.find(params["id"]).stories
  erb :"/stories/index"
end

get "/users/:id/stories/:id" do
  
end