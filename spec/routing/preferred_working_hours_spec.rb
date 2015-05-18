require 'rails_helper'

describe 'preferred_working_hours' do
  it "edit" do
    expect(get('/preferred_working_hours/edit')).to route_to('preferred_working_hours#edit')
  end

  it "update" do
    expect(put('/preferred_working_hours')).to route_to('preferred_working_hours#update')
  end
end
