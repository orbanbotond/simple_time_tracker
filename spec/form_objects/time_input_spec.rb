require 'rails_helper'

describe TimeInput do
  context 'fields' do
    #TODO use the specific matchers
    it { is_expected.to respond_to(:start_time) }
    it { is_expected.to respond_to(:end_time) }
    it { is_expected.to respond_to(:date) }
    it { is_expected.to respond_to(:description) }
  end   

  context 'validations' do
    let(:params) { { description: 'lorem', start_time: '08:21', end_time: '09:12', date: '03/15/2015' } }
    specify 'description should be present' do
      expect(TimeInput.new params.except(:description)).to_not be_valid
    end
    specify 'start_time should be present' do
      expect(TimeInput.new params.except(:start_time)).to_not be_valid
    end
    specify 'end_time should be present' do
      expect(TimeInput.new params.except(:end_time)).to_not be_valid
    end
    specify 'date should be present' do
      expect(TimeInput.new params.except(:date)).to_not be_valid
    end
  end   
end
