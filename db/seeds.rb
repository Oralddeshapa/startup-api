# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do
  user = User.create(
    username: Faker::Name.first_name,
    password: Faker::Code.nric,
    email: Faker::Internet.email,
    role: rand(2),
  )
  user.save
  idea = user.ideas.create(
    title: Faker::Tea.variety,
    problem: Faker::Lorem.paragraph,
    region: rand(8),
    field: rand(6),
    close_date: Time.now + 30.days,
  )
  idea.save
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
AdminUser.create!(email: Rails.application.credentials.admin_email, password: Rails.application.credentials.admin_pass, password_confirmation: Rails.application.credentials.admin_pass)
