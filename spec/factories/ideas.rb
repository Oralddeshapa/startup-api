FactoryBot.define do
  factory :idea do
    title { Faker::Tea.variety }
    problem { Faker::Lorem.paragraph }
    rating { 1 }
    region { 'RU' }
    field { "science" }
  end
end
