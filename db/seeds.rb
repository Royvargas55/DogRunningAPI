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