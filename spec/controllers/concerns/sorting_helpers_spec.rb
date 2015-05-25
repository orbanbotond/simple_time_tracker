require 'rails_helper'

class Dummy
  class << self
    def column_names
      [:name, 'dummy_sort_column']
    end
  end
end

class DummyController < ActionController::Base
  include SortingHelpers

  def resource_class
    Dummy
  end

  def params
    {direction: 'asc', sort: 'dummy_sort_column'}
  end
end

class Admin::DummyController < ActionController::Base
  include SortingHelpers

  def resource_class
    Dummy
  end

  def params
    {direction: 'asc', sort: 'dummy_sort_column'}
  end

end

shared_examples "SortingHelper" do
  specify 'sort column is the one coming from the params' do
    expect(subject.sort_column).to eq('dummy_sort_column')
  end
  specify 'sort direction is comming from the params' do
    expect(subject.sort_direction).to eq('asc')
  end
end

describe Admin::DummyController do
  it_behaves_like 'SortingHelper'
end
