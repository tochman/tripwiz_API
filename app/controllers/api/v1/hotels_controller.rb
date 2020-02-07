class Api::V1::HotelsController < ApplicationController
  
  def create
    getHotels = get_hotels(params)
    hotels = []

    if getHotels.length >= 3
      getHotels.each do |i|
        name = i['hotel']['name']
        lat = i['hotel']['latitude']
        lng = i['hotel']['longitude']
        price = i['hotel']['longitude']
        address = i['hotel']['address']['lines'][0]
        
        hotel = Hotel.create(
          name: name,
          lat: lat,
          lng: lng,
          price: price,
          address: address,
          trip_id: params[:trip_id]
        )
        hotels << hotel if hotel.persisted?
      end
      hotels
    end
    
    if hotels != []
      render json: hotels
    else
      render json: { error: hotel.errors.full_messages }, status: 422
    end
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