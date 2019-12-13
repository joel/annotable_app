# frozen_string_literal: true
FactoryBot.define do
  factory :note do
    title { FFaker::Lorem.words.join('') }
    content { FFaker::Lorem.sentence }
    report
  end
end
