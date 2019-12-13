require 'rails_helper'

RSpec.describe Note, type: :model do
  let(:report) { FactoryBot.create(:report) }
  let(:note)   { described_class.new attributes }

  context 'valid_attributes' do
    let(:valid_attributes) {
      FactoryBot.attributes_for(:note).merge(report: report)
    }
    let(:attributes) { valid_attributes }
    it { expect(note).to be_valid }
  end

  context 'invalid_attributes' do
    let(:invalid_attributes) {
      FactoryBot.attributes_for(:note).merge(report: report).except(:title)
    }
    let(:attributes) { invalid_attributes }
    it do
      expect(note).not_to be_valid
      expect(note.errors.messages).to eql({title: ["can't be blank"]})
    end
  end
end
