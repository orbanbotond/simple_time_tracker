require 'rails_helper'

feature 'Listing Work Sessions' do
  scenario 'unsigned' do
    visit '/'
    expect(page).to have_content("You need to sign in")
    expect(page.current_url).to eq(new_user_session_url)
  end

  context 'logged in' do
    let(:user) { create :user }
    let(:filter_low) { Date.parse '02/03/2015' }
    let(:filter_high) { Date.parse '03/03/2015' }
    let!(:work_day_0) { create :work_day, date: (filter_low - 1.days), user: user }
    let!(:work_day_1) { create :work_day, date: filter_low, user: user }
    let!(:work_day_2) { create :work_day, date: filter_high, user: user }
    let!(:work_day_3) { create :work_day, date: (filter_high + 1.days), user: user }
    let!(:work_session_1) { create :work_session, work_day: work_day_0 }
    let!(:work_session_2) { create :work_session, work_day: work_day_1 }
    let!(:work_session_3) { create :work_session, work_day: work_day_2 }
    let!(:work_session_4) { create :work_session, work_day: work_day_3 }

    scenario 'without filtering' do
      visit '/'
      sign_in user, user.password
      expect(page).to have_selector('tr.work_session', count: 4)
    end

    scenario 'with filtering' do
      visit '/'
      sign_in user, user.password
      fill_in 'filter_from', with: filter_low.strftime("%d/%m/%Y")
      fill_in 'filter_to', with: filter_high.strftime("%d/%m/%Y")
      click_button 'Filter'
      expect(page).to have_selector('tr.work_session', count: 2)
    end
  end
end
