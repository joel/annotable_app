FactoryBot.define do
  factory :organization do
    initialize_with do
      organization = Fabricate.create(:organization).reload

      new({
        name: organization.name
      })
    end

    # set back from the database the instance.legacy_id
    after(:create) { |instance| instance.reload }
  end
end
