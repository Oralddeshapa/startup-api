# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do
  Idea.create(
    title: Faker::Tea.variety,
    problem: Faker::Lorem.paragraph,
    rating: rand(6),
    region: rand(8),
    field: rand(6),
  )
end

10.times do
  User.create(
    username: Faker::Name.name,
    password: Faker::Tea.variety,
    email: Faker::Internet.email,
  )
end
