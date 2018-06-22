def assert_status_code(expected_code, response, action)
  assert_equal(expected_code, response.code, "#{action} failed!
      Status code is not correct!
      Expected : #{expected_code}
      Received : #{response.code}
      Response received : #{response}")
end
