FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name + 'Jnr' }
    password { Faker::Internet.email }
    email { Faker::Code.nric }
    role { 'temporary_role' }
  end
end
