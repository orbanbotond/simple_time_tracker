require 'rails_helper'

feature 'Handling Tasks' do
  scenario 'unsigned' do
    visit '/'
    expect(page).to have_content("Log in")
    expect(page.current_url).to eq(new_user_session_url)
  end
end
