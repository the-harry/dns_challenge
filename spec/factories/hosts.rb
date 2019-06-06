FactoryBot.define do
  factory :host do
    sequence(:url) { |n| "foo#{n}bar.com" }
  end
end
