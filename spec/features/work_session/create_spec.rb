require 'rails_helper'

feature 'Creating Tasks' do
  scenario 'unsigned' do
    visit '/'
    expect(page).to have_content("You need to sign in")
    expect(page.current_url).to eq(new_user_session_url)
  end

  context 'logged in' do
    let(:user) { create :user }
    scenario 'create' do
      visit '/'
      sign_in user, user.password
      click_on 'Register A New Work Session', :match => :first
      fill_in 'Description', :with => 'Bootstrapping the project'
      # select_date Date.parse('2014-05-18'), from: 'work_session_date'
      # select_time Time.parse('02:20'), :from => 'work_session_start_time'
      # select_time Time.parse('03:40'), :from => 'work_session_end_time'
      fill_in 'work_session_date', with: '18/05/2014'
      fill_in 'work_session_start_time', :with => '02:20'
      fill_in 'work_session_end_time', :with => '03:40'
      click_button 'Create Work session'
      expect(page).to have_content("Time Sheet")
      expect(page).to have_content("Work session was successfully created.")
    end
  end
end
