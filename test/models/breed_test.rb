require "test_helper"

describe Breed do
  let(:breed) { Breed.new }
  let(:one) { breeds(:one) }

  it 'must be valid' do
    one.valid?.must_equal true
  end

  it 'must have an breed' do
    breed.valid?.must_equal false
    breed.breed = 'Breed'
    breed.valid?.must_equal true
  end
end
