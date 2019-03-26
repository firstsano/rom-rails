require 'rails_helper'

RSpec.describe Volgaspot::TariffsRelation, type: :relation do
  describe 'schema' do
    subject { described_class.schema.to_output_hash }

    context 'when tuple has empty active_tariff_link' do
      let(:tariff_link) { create :volgaspot_tariff, :with_services }

      it 'should transform it into empty hash' do
        response = subject.call tariff_link
        expect(response[:active_tariff_link]).to eq({})
      end
    end

    context 'when tuple has empty services' do
      let(:tariff_link) { create :volgaspot_tariff, :with_active_tariff }

      it 'should transform it into empty array' do
        response = subject.call tariff_link
        expect(response[:services]).to eq([])
      end
    end

    it 'should raise error if tuple has empty id' do
      tariff_link = create :volgaspot_tariff, :complete, id: nil
      expect { subject.call(tariff_link) }.to raise_error ::Dry::Types::SchemaError
    end
  end
end
