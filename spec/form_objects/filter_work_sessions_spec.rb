require 'rails_helper'

describe FilterWorkSessions do
  context 'fields' do
    it { is_expected.to respond_to(:from) }
    it { is_expected.to respond_to(:to) }

    context 'typecasting' do
      specify 'should converyt to date' do
        expect(FilterWorkSessions.new(from: '01/02/2015').from).to be_a(Date)
      end
    end
  end   

  context 'validations' do
    context 'validates that the from is before the to' do
      let(:filter) { FilterWorkSessions.new from: '22/05/2014', to: '21/05/2014' }

      specify 'should be invalid and contain the proper error message' do
        expect(filter).to_not be_valid
        expect(filter.errors[:from]).to include('to must be after from')
      end
    end

    context 'validates that the to is not in the future' do
      let(:filter) { FilterWorkSessions.new from: '22/05/2014', to: 1.day.from_now }

      specify 'should be invalid and contain the proper error message' do
        expect(filter).to_not be_valid
        expect(filter.errors[:to]).to include('to can\'t be in the future')
      end
    end
  end

  context 'methods' do
    context '#filtering?' do
      it { is_expected.to respond_to(:filtering?) }

      specify 'returns true if the from and to are present' do
        filter = FilterWorkSessions.new from: '01/02/2015', to: '02/02/2015'
        expect(filter.filtering?).to be_truthy
      end

      specify 'returns false unless the from and to are present' do
        filter = FilterWorkSessions.new  to: '02/02/2015'
        expect(filter.filtering?).to be_falsy
      end

      specify 'returns false unless the from and to are present' do
        filter = FilterWorkSessions.new  from: '02/02/2015'
        expect(filter.filtering?).to be_falsy
      end

      specify 'returns false unless the from and to are present' do
        filter = FilterWorkSessions.new
        expect(filter.filtering?).to be_falsy
      end
    end
  end
end
