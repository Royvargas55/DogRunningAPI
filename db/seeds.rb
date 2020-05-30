# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
100.times do |n|
    Breed.create(
      breed: (Faker::Creature::Dog.unique.breed).downcase
    )
  end
  
  1000.times do |n|
    Dog.create(
      name:   Faker::Creature::Dog.name,
      age:    Faker::Number.number(digits: 2),
      weight: Faker::Number.number(digits: 2),
      breeds: (Faker::Creature::Dog.breed).downcase
    )
  end