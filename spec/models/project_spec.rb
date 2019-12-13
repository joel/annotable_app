require 'rails_helper'

RSpec.describe Project, type: :model do
  let(:organization) { FactoryBot.create :organization}
  let(:project) { described_class.new(attributes.merge({ organization: organization })) }

  context 'valid_attributes' do
    let(:valid_attributes) {
      FactoryBot.attributes_for(:project)
    }
    let(:attributes) { valid_attributes }
    it { expect(project).to be_valid }
  end

  context 'invalid_attributes' do
    let(:invalid_attributes) {
      FactoryBot.attributes_for(:project).except(:name)
    }
    let(:attributes) { invalid_attributes }
    it { expect(project).not_to be_valid }
  end
end
