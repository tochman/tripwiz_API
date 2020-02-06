FactoryBot.define do
  factory :activity_type do
    type { "museum" }
    association :trip
  end
end
