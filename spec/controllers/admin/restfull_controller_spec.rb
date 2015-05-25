require 'rails_helper'

describe Admin::RestfullController do
  context 'class' do
    context 'hierarchy' do
      specify {expect(subject).to be_kind_of(Admin::BaseController)}
      specify {expect(subject).to be_kind_of(SortingHelpers)}
    end
  end
end
