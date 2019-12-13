require 'rails_helper'

RSpec.describe Report, type: :model do
  let(:project) { FactoryBot.create :project }
  let(:report)  { described_class.new(attributes.merge({ project: project })) }

  context 'valid_attributes' do
    let(:valid_attributes) {
      FactoryBot.attributes_for(:report)
    }
    let(:attributes) { valid_attributes }
    it { expect(report).to be_valid }
  end

  context 'invalid_attributes' do
    let(:invalid_attributes) {
      FactoryBot.attributes_for(:report).except(:name)
    }
    let(:attributes) { invalid_attributes }
    it { expect(report).not_to be_valid }
  end
end
