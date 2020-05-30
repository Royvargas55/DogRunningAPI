class Breed < ApplicationRecord
  validates :breed, presence: true
  after_save :clear_cache

  private
  def clear_cache
    REDIS.del "breeds"
  end
end
