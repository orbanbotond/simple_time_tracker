require 'rails_helper'

describe Admin::UsersController do
  context "class hierarchy" do
    specify {expect(subject).to be_kind_of(Admin::RestfullController)}
  end

  context 'methods' do
    permitted_for_form = [:email, :name]

    specify{expect(subject.permitted_for_form).to eq permitted_for_form}
  end
end
