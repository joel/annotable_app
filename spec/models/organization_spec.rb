require 'rails_helper'

RSpec.describe Organization, type: :model do
  let(:organization) { described_class.new attributes }

  context 'valid_attributes' do
    let(:valid_attributes) {
      FactoryBot.attributes_for(:organization)
    }
    let(:attributes) { valid_attributes }
    it { expect(organization).to be_valid }
  end

  context 'invalid_attributes' do
    let(:invalid_attributes) {
      FactoryBot.attributes_for(:organization).except(:name)
    }
    let(:attributes) { invalid_attributes }
    it { expect(organization).not_to be_valid }
  end
end
