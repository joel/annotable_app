FactoryBot.define do
  factory :user do
    transient do
      _attributes { user_attributes }
      _name  { _attributes[:name] }
      _email { _attributes[:email] }
    end
    name  { _name }
    email { _email }

    trait :with_organization do
      organization
    end
  end
end
