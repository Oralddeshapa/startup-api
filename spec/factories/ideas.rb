FactoryBot.define do
  factory :idea do
    title { Faker::Tea.variety }
    problem { Faker::Lorem.paragraph }
    rating { rand(6) }
    region { rand(8) }
    field { rand(6) }
  end
end
