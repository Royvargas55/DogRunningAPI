class DogSerializer < ActiveModel::Serializer
  has_many :reservations
  attributes :id, :name, :age, :weight, :breed_list
end
