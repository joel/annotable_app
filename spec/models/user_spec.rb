require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { described_class.new attributes }

  context 'valid_attributes' do
    let(:valid_attributes) {
      FactoryBot.attributes_for(:user)
    }
    let(:attributes) { valid_attributes }
    it { expect(user).to be_valid }
  end

  context 'invalid_attributes' do
    let(:invalid_attributes) {
      FactoryBot.attributes_for(:user).except(:email)
    }
    let(:attributes) { invalid_attributes }
    it { expect(user).not_to be_valid }
  end
end
