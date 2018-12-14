require 'rails_helper'

RSpec.describe Volgaspot::TariffsRelation, type: :relation do
  describe 'schema' do
    subject { described_class.schema.to_output_hash }

    it 'should parse data' do
      data = { id: 123, active_tariff_link: nil, services: nil }
      response = subject.call data
      expect(response[:active_tariff_link]).to eq({})
      expect(response[:services]).to eq([])
    end
  end
end