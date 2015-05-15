require 'rails_helper'
require_relative 'restfull_routes'

describe 'routes for the tasks' do
  it_behaves_like 'Restfull Resource Routes', :tasks, [:index, :create, :new]
end
