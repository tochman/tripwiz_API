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
    response = JSON.parse RestClient.get "https://api.amadeus.com/v2/shopping/hotel-offers?latitude=#{params[:lat]}&longitude=#{params[:lng]}&roomQuantity=1&adults=2&radius=1&radiusUnit=KM&ratings=5&currency=SEK&paymentPolicy=NONE&includeClosed=false&bestRateOnly=true&view=FULL&sort=NONE&page[limit]=3"
    hotels = response
  end
  
end