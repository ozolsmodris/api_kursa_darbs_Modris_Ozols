Given(/^I have logged in as a register user$/) do
  @user = User.new(email: 'modris.ozols@testdevlab.com', password: 'Parole123')
  login_positive(user: @user)
end