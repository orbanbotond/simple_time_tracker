require 'rails_helper'

feature 'User signup' do
  scenario 'Successfull Sign Up' do
    visit '/'
    click_link "Sign up"
    fill_in "Name", :with => "John Smith"
    fill_in "Email", :with => "user@example.com"
    fill_in "Password", :with => "password"
    fill_in "Password confirmation", :with => "password"
    click_button "Sign up"
    expect(page).to have_content("You have signed up successfully.")
    expect(page.current_url).to eq(root_url)
  end
  context 'Unsuccessfull Sign Up' do
    scenario 'Name is missing' do
      visit '/'
      click_link "Sign up"
      fill_in "Email", :with => "user@example.com"
      fill_in "Password", :with => "password"
      fill_in "Password confirmation", :with => "password"
      click_button "Sign up"
      expect(page).to have_content('Name can\'t be blank')
    end
    scenario 'Email is missing' do
      visit '/'
      click_link "Sign up"
      fill_in "Name", :with => "John Smith"
      fill_in "Password", :with => "password"
      fill_in "Password confirmation", :with => "password"
      click_button "Sign up"
      expect(page).to have_content('Email can\'t be blank')
    end
    scenario 'Pwd is missing' do
      visit '/'
      click_link "Sign up"
      fill_in "Email", :with => "user@example.com"
      fill_in "Name", :with => "John Smith"
      click_button "Sign up"
      expect(page).to have_content("Password can't be blank")
    end      
  end
end
