class Reservation < ApplicationRecord
    belongs_to :dog
    validates :reservation_date, :dog_id, presence: true
end