def get_random_users_post(user:, post:)
  body = {
    email: user.email,
    password: user.password
  }.to_json

  response = API.get('http://195.13.194.180:8090/api/posts',
                      headers: { authorization: user.auth_token })

  # Check if response 200 OK
  assert_status_code(200, response, 'Get All Posts')
  resp = JSON.parse(response)
  post_data = resp.reject!{|post| post["author"]["id"] == user.id}.sample
  post.id = post_data["id"]
  post.author = post_data["author"]["id"]
  post.title = post_data["title"]
  post.content = post_data["content"]
  post.created_at = post_data["createdAt"]
  post.updated_at = post_data["updatedAt"]
end

def edit_post_title_negative(user:, post:)
  payload = {
    title: "#{post.title} + Changed + #{user.firstname}}"
  }.to_json
  response = API.put("http://195.13.194.180:8090/api/post?post_id=#{post.id}",
                      headers: { authorization: user.auth_token },
                      payload: payload)

  resp = JSON.parse(response)
  assert_status_code(403, response, 'Post updated')
  resp = JSON.parse(response)
  assert_equal('Forbidden', resp['error'], "Post title doesn't match")
  assert_equal('You cannot edit a post that has not been created by you!', resp['message'], "Post error message did not match")
end