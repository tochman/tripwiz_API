FactoryBot.define do
  factory :activity do
    name { "Museum" }
    address { "Stockholmsgatan 1, Stockholm" }
    rating { "4.2" }
    lat { "55.123" }
    lng { "12.345" }
    association :activity_type
  end
end
