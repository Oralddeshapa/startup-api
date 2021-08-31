FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name + 'Jnr' }
    password { Faker::Code.nric }
    email { Faker::Internet.email[0,39] }
    role { 'creator' }
  end
end
