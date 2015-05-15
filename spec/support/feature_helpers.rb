module Features
  module SessionHelpers
    def sign_in(user = nil, pwd = nil)
      default_pwd = 'Passw0rd'
      visitor = user || create( :user, email: 'orbanbotond@gmail.com', password: default_pwd, password_confirmation: default_pwd)
      password = pwd || default_pwd
      visit new_user_session_path
      fill_in "user_email", with: visitor.email
      fill_in 'user_password', with: password
      click_on 'Log in'
    end
  end
end

RSpec.configure do |config|
  config.include Features::SessionHelpers, type: :feature
end