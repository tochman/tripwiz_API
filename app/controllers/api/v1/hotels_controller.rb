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
    response = amadeus.shopping.hotel_offers.get({ 
      cityCode: 'STO', 
      ratings: 5, 
      roomQuantity: 1, 
      adults: 2, 
      radius: 1, 
      radiusUnit: 'KM',
      paymentPolicy: 'NONE',
      includeClosed: false,
      bestRateOnly: false,
      view: 'LIGHT',
      sort: 'NONE'})
    hotels = JSON.parse(response.body)
    hotelsFinal = hotels['data'].slice(0, 3)
  end
  
end