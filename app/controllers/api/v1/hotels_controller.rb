class Api::V1::HotelsController < ApplicationController
  
  def create
    hotels = get_hotels(params)
    binding.pry
    # hotels = Hotel.create(destination: destination,
    #   lat: params[:lat],
    #   lng: params[:lng],
    #   days: params[:days])

      # if trip.persisted?
      #   render json: trip
      # else
      #   render json: { error: trip.errors.full_messages }, status: 422
      # end
  end

  private

  def get_hotels(params)
    amadeus = Amadeus::Client.new({hostname: :production,
      client_id: 'yAuxmqs01U77qZcA7EuPAKUzkqKaOqGi',
      client_secret: 'Kp4VhKkJkKBSNEM7'
    })
    response = amadeus.shopping.hotel_offers.get(latitude: params[:lat], longitude: params[:lng], ratings: params[:rating], view: 'LIGHT')
    hotels = JSON.parse(response.body)
    hotelsFinal = hotels['data'].slice(0, 3)
  end
  
end