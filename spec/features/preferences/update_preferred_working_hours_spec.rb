require 'rails_helper'

feature 'Update Preferred Working Hours' do
  scenario 'unsigned' do
    visit '/'
    expect(page).to have_content("Log in")
    expect(page.current_url).to eq(new_user_session_url)
  end

  context 'logged in' do
    let(:user) { create :user }
  
    scenario 'create' do
      visit '/'
      sign_in user, user.password
      click_on 'preferences'
      check('0 - 1')
      check('2 - 3')
      click_button 'Save'
      box = find('#0')
      expect(box).to be_checked
      box = find('#2')
      expect(box).to be_checked
      expect(page).to have_content("The preferences were saved")
    end
  end
end
