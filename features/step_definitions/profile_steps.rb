Then(/^I can access my profile information$/) do
  check_profile_information(user: @user)
end

When(/^I change First and Last name to new$/) do
  @tempuser = @user.dup
  @tempuser.firstname = @tempuser.firstname.reverse
  @tempuser.lastname = @tempuser.lastname.reverse
  change_profile_information(user: @tempuser)
end

Then(/^I check if profile information is changed$/) do
  check_profile_information(user: @tempuser)
end

Then(/^I change user information back to original$/) do
  change_profile_information(user: @user)
  check_profile_information(user: @user)
end