def login_positive(user:)
  body = {
    email: user.email,
    password: user.password
  }.to_json

  response = API.post('http://195.13.194.180:8090/api/login',
                      payload: body)

  # Check if response 200 OK
  assert_status_code(200, response, 'Login')
  resp = JSON.parse(response)
  # Check if correct user is returned
  assert_equal(user.email, resp['email'], "Resp email #{resp['email']} doesn't match #{user.email}")
  user.firstname = resp['firstName']
  user.lastname = resp['lastName']
  user.id = resp['id']
  user.auth_token = response.headers[:authorization]
end
