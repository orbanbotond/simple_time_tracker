require 'rails_helper'

describe Admin::BaseController do
  context 'class' do
    context 'hierarchy' do
      specify {expect(subject).to be_kind_of(ApplicationController)}
      specify {expect(subject).to be_kind_of(RestrictedForRoles)}
    end
  end

  context 'security context' do
    specify{expect(subject.class.accessor_roles).to include(:admin)}
  end
end
