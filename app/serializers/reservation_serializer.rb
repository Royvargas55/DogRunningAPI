class ReservationSerializer < ActiveModel::Serializer
    belongs_to :dog
    attributes :id, :reservation_date, :notes, :dog_id
end
  