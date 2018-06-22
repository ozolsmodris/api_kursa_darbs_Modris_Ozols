After('@editProfile') do |scenario|
    check_profile_information(user: @user) if scenario.failed?
end