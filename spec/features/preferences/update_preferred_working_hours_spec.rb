require 'rails_helper'

feature 'Update Preferred Working Hours' do
  scenario 'unsigned' do
    visit '/'
    expect(page).to have_content("You need to sign in")
    expect(page.current_url).to eq(new_user_session_url)
  end

  context 'logged in' do
    let!(:user) { create :user }
    let!(:preferences) { create :preferred_working_hour, user: user, hour: 5}

    scenario 'edit' do
      visit '/'
      sign_in user
      click_on "Preferences #{user.name}"
      box = find('#5')

      expect(box).to be_checked
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
