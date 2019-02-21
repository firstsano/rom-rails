require 'rails_helper'

RSpec.describe Volgaspot::PaymentsRelation, type: :relation do
  describe 'schema' do
    subject(:schema) { described_class.schema.to_output_hash }
    let(:required_fields) { %i[id status paid payment_method test amount] }

    context 'valid tuples' do
      let(:tuple) { create :volgaspot_payment }

      it 'processes default payment' do
        expect { schema.call tuple }.not_to raise_error
      end

      it 'processes payment with bank_card' do
        tuple = create :volgaspot_payment, :with_bank_card_method
        expect { schema.call tuple }.not_to raise_error
      end

      it 'sets required fields' do
        payment = schema.call tuple
        required_fields.each do |field|
          expect(payment[field]).not_to be_nil
        end
        expect(payment[:amount][:value]).not_to be_nil
        expect(payment[:amount][:currency]).not_to be_nil
      end
    end

    context 'invalid tuples' do
      it 'raises error' do
        required_fields.each do |field|
          tuple = create :volgaspot_payment, field => nil
          expect { schema.call tuple }.to raise_error ::Dry::Types::SchemaError
        end
      end
    end
  end
end
