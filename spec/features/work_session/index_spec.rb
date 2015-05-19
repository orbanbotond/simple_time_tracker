require 'rails_helper'

feature 'Listing Work Sessions' do
  scenario 'unsigned' do
    visit '/'
    expect(page).to have_content("You need to sign in")
    expect(page.current_url).to eq(new_user_session_url)
  end

  context 'logged in' do
    let(:user) { create :user }
    let!(:work_session_1) { create :work_session }
    let!(:work_session_old) { create :work_session, date: 2.days.ago }
    let!(:work_session_old_2) { create :work_session, date: 3.days.ago }

    scenario 'without filtering' do
      visit '/'
      sign_in user, user.password
      expect(page).to have_selector('tr.work_session', count: 3)
    end

    scenario 'with filtering' do
      visit '/'
      sign_in user, user.password
      fill_in 'filter_from', with: Time.now.strftime("%d/%m/%Y")
      fill_in 'filter_to', with: Date.today
      click_button 'Filter'
      expect(page).to have_selector('tr.work_session', count: 1)
    end
  end
end
