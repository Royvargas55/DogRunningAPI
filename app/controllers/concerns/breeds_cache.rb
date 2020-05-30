require 'json'
module BreedsCache
  def fetch_breeds
    breeds = REDIS.get("breeds")
    if breeds.nil?
      breeds = Breed.all.to_json
      REDIS.set("breeds", breeds)
      REDIS.expire("breeds", 5.hour.to_i)
    end
    @breeds = JSON.load breeds
  end
end