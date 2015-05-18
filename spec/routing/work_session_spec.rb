require 'rails_helper'
require_relative 'restfull_routes'

describe 'routes for the work sessions' do
  it_behaves_like 'Restfull Resource Routes', :work_session, [:index, :create, :new]
end
