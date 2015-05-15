require 'rails_helper'

describe 'root route' do
  it "routes / to the tasks" do
    expect(get('/')).to route_to('tasks#index')
  end
end
