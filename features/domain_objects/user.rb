class User
  attr_accessor :id, :email, :firstname, :lastname, :password, :auth_token

  def initialize(email:, password:)
    self.email = email
    self.password = password
  end
end
