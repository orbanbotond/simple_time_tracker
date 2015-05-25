require 'rails_helper'

describe 'routes for the users' do
  it_behaves_like 'Admin Resource Routes', :user
end