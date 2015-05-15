require 'rails_helper'

feature 'User sign in' do
  scenario 'successfull sign in' do
    visit root_url
    sign_in
    expect(page).to have_content("Signed in successfull")
    expect(page.current_url).to eq(root_url)
  end
  context "unsuccessfull sign in" do
    scenario 'email is wrong' do
      visit root_url
      sign_in(build( :user, email: 'wrong@email.com'))
      expect(page).to have_content("Invalid email or password")
      expect(page.current_url).to eq(new_user_session_url)
    end
    scenario 'password is wrong' do
      visit root_url
      sign_in(nil, 'wrong_pwd')
      expect(page).to have_content("Invalid email or password")
      expect(page.current_url).to eq(new_user_session_url)
    end
  end
end
