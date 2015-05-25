require 'rails_helper'

describe 'routes for the admin dashboard' do
  specify 'index' do
    expect(:get => admin_root_path).
      to route_to :controller => 'admin/dashboard', :action => 'index'
  end
end
