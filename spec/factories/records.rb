FactoryBot.define do
  factory :record do
    sequence(:ip) { |n| "#{n}.#{n}.#{n}.#{n}" }
  end
end
