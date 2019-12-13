FactoryBot.define do
  factory :project do
    name { FFaker::Company.name }
    organization
  end
end
