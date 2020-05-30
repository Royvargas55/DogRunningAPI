class Dog < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :age, :weight, presence: true
  validates :name, presence: true
  validates :age, :weight, :numericality => { :greater_than => 0 }
  validates_format_of :name, :with => /\A[^<>~!$;=?@`|{}]+\z/, :on => :create, :message => 'Contains an invalid symbol <>~!$;=?@`|{}'
  validates :breeds, presence: true
  validates_format_of :breeds, :with => /\A[^<>~!$;=?@`|{}]+\z/, :on => :create, :message => 'Contains an invalid symbol <>~!$;=?@`|{}'
  after_save :clear_cache

  private

  def clear_cache
    REDIS.del "dogs"
  end
  
  def breed_list
    self.breeds = self.breeds.split(",").map(&:strip)
  end

  def self.add_breed(dog)
    breed_array = dog.breeds.downcase.split(",").map(&:strip)

    breed_array.each do |i|
      if Breed.where('breed LIKE ? ', "%#{i}%").count == 0
        new = Breed.new
        new.breed = i
        new.save
      end
    end
  end

  def self.search(q)
    q = (q.downcase || nil).split(' ')
    dogs = []

    dogs = Dog.where("concat_ws(' ', name, breeds) ILIKE ?", "%#{q[0]}%") if q.length

    if q.length > 1
      i = 1
      (q.length - 1).times do
        dogs = dogs.select do |object|
          (object.name.include? q[i]) || (object.breeds.include? q[i])
        end
        i += 1
      end
    end

    return dogs
  end
end