# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
10.times do
  user = ActiveRecord::Base.conenction.exec_quert(`INSERT INTO "users" (first_name, password, email, role) VALUES(#{Faker::Name.first_name}, #{Faker::Code.nric}, #{Faker::Internet.email}, #{rand(2)})`)
  idea = ActiveRecord::Base.conenction.exec_quert(`INSERT INTO "ideas" (title, problem, region, field) VALUES(#{Faker::Tea.variety}, #{Faker::Lorem.paragraph}, #{Faker::Internet.email}, #{rand(2)})`)
end
