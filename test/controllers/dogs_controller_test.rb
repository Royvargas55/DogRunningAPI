require "test_helper"

describe DogsController do
  describe 'index' do
    before do
      get dogs_url
    end

    it 'is a real working route' do
      must_respond_with :success
    end

    it 'returns json' do
      response.header['Content-Type'].must_include 'json'

      body = JSON.parse(response.body)
      body.must_be_kind_of Array
    end

    it 'returns all dogs' do
      body = JSON.parse(response.body)
      body.length.must_equal Dog.count
    end
  end

  describe 'show' do
    before do
      get dog_path(dogs(:one).id)
    end

    it 'can get a single dog' do
      must_respond_with :success
    end

    it 'returns an error if dog is invalid' do
      dogs(:one).destroy()
      get dog_path(dogs(:one).id)
      must_respond_with :not_found
    end
  end

  describe 'create' do
    let(:one) { breeds(:one) }
    let(:dog_data) {
      { name: "8",
        age: "8",
        weight: "8",
        breeds: 'Jojoba oil'
      }
    }
    let(:ingred_data) {
      { name: 'Test data',
        age: "8",
        weight: "8",
        breeds: 'MYSTRING'
      }
    }

    it 'can create a new dog' do
      assert_difference 'Dog.count', 1 do
        post dogs_url, params: dog_data
        assert_response :success
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "id"

      Dog.find(body["id"]).name.must_equal dog_data[:name]
    end

    it 'returns errors for invalid dogs' do
      bad_data = dog_data.clone()
      bad_data.delete(:name)
      assert_no_difference "Dog.count" do
        post dogs_url, params: bad_data
        assert_response :bad_request
      end

      body = JSON.parse(response.body)
      body.must_be_kind_of Hash
      body.must_include "errors"
      body["errors"].must_include "name"
    end

    it 'adds breeds to all_breeds if not in the db' do
      Breed.where('breed LIKE ? ', "jojoba oil").count.must_equal 0

      assert_difference 'Dog.count', 1 do
        post dogs_url, params: dog_data
        assert_response :success
      end

      Breed.where('breed LIKE ? ', "jojoba oil").count.must_equal 1
    end

    it 'does not add breed if already in breed db' do
      Breed.first.breed.must_equal "mystring"

      assert_difference 'Dog.count', 1 do
        post dogs_url, params: ingred_data
        assert_response :success
      end

      Breed.where('breed LIKE ? ', "mystring").count.must_equal 1
    end
  end
end
