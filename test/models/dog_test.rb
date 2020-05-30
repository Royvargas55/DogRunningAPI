require "test_helper"

describe Dog do
  let(:dog) {Dog.new}
  let(:one) { dogs(:one) }

  it 'must be valid' do
    one.valid?.must_equal true
  end

  it 'must have a title, brand, and breeds' do
    dog.valid?.must_equal false
    dog.name = 'Name'
    dog.valid?.must_equal false
    dog.age = 8
    dog.valid?.must_equal false
    dog.weight = 8
    dog.valid?.must_equal false
    dog.breeds = 'Breeds'
    dog.valid?.must_equal true
  end
end
