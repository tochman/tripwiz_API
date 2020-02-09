FactoryBot.define do
  factory :activity do
    name { "Museum" }
    address { "Stockholmsgatan 1, Stockholm" }
    rating { "4.2" }
    lat { "59.#{rand(100)}" }
    lng { "18.#{rand(100)}" }
    association :activity_type
  end
end
