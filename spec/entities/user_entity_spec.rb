require 'rails_helper'

describe Entities::UserEntity do
  describe 'fields' do
    subject(:subject) { Entities::UserEntity }
    specify { expect(subject).to represent(:email)}
    specify { expect(subject).to represent(:name)}
  end
end
