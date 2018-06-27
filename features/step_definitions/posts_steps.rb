Given(/^I get random users post$/) do
  @post = Post.new
  @random_user_id = get_random_users_post(user: @user, post: @post)
end

When(/^I edit other users post$/) do
  edit_post_title_negative(user: @user, post: @post)
end