require "test_helper"

describe BreedsController do
  before do
    get breeds_url
  end

  it 'is a real working route' do
    must_respond_with :success
  end

  it 'returns json' do
    response.header['Content-Type'].must_include 'json'

    body = JSON.parse(response.body)
    body.must_be_kind_of Array
  end

  it 'returns all breeds' do
    body = JSON.parse(response.body)
    body.length.must_equal Breed.count
  end
end
