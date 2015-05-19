require 'rails_helper'

describe FilterWorkSessions do
  context 'fields' do
    it { is_expected.to respond_to(:from) }
    it { is_expected.to respond_to(:to) }

    context "typecasting" do
      specify 'should converyt to date' do
        expect(FilterWorkSessions.new(from: '01/02/2015').from).to be_a(Date)
      end
    end
  end   

  context "methods" do
    context "#filtering?" do
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
