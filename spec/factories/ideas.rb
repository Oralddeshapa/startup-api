FactoryBot.define do
  factory :idea do
    title { Faker::Tea.variety }
    problem { Faker::Lorem.paragraph }
    region { 'RU' }
    field { "science" }
  end
end
