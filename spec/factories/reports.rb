FactoryBot.define do
  factory :report do
    name { FFaker::Product.product_name }
    content { FFaker::Lorem.paragraph }
    project 
  end
end
