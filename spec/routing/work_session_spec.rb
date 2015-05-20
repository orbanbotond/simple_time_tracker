require 'rails_helper'
require_relative 'restfull_routes'

describe 'routes for the work sessions' do
  it_behaves_like 'Restfull Resource Routes', :work_session, [:index, :create, :new]

  it "routes /download" do
    expect(get('/work_sessions/download')).to route_to('work_sessions#download')
  end

end
