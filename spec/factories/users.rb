FactoryBot.define do
  factory :user do
    initialize_with do
      Fabricate.create(:user).reload
    end

    trait :with_organization do
      organization
    end

    # set back from the database the instance.legacy_id
    after(:create) { |instance| instance.reload }
  end
end
