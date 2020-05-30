class ReservationsController < ApplicationController
    before_action :set_reservation, except: :create
    before_action :parse_start_time, only: %i[update create]
    before_action :set_dog, only: [:create]

    def show
        json_response(@reservation)
    end

    def update
        @reservation.update(reservation_params)
        json_response(@reservation)
    end

    def create
        if @dog.reservations.count < 1
            @reservation = Reservation.create(reservation_params.merge(dog_id: params[:dog_id]))
            json_response(@reservation)
        end
    end

    def destroy
        json_response(@reservation.destroy)
    end

    private

    def reservation_params
        params.require(:reservation).permit(:reservation_date, :notes)
    end

    def parse_start_time
        return unless params[:reservation][:start_time].is_a?(String)

        params[:reservation][:start_time] = Time.at(params[:reservation][:start_time].to_i).to_datetime
    end

    def set_reservation
        @reservation = Reservation.find(params[:id])
    end

    def set_dog
        @dog   = Dog.find_by_id!(params[:id] || params[:dog_id])
    end
end