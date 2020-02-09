class Api::V1::HotelsController < ApplicationController
  
  def create
    activity_type = ActivityType.find_by(trip_id: params[:trip_id])
    
    if activity_type.activities != []
      lats = []
      longs = []
      activity_type.activities.each do |i|
        lat = i['lat']
        lng = i['lng']
        
        lats << lat.to_f
        longs << lng.to_f
      end
      avg_lat = lats.inject{ |sum, el| sum + el } / lats.size
      avg_lng = longs.inject{ |sum, el| sum + el } / longs.size
      lat = avg_lat.round(5)
      lng = avg_lng.round(5)
    end

    getHotels = get_hotels(params, lat, lng) 
    hotels = []

    if getHotels != 'error'
      getHotels.each do |i|
        name = i['hotel']['name']
        lat = i['hotel']['latitude']
        lng = i['hotel']['longitude']
        price = i['offers'][0]['price']['total']
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
      render json: { error: "No hotels found, try a different hotel rating or location."}, status: 400
    end
  end

  private

  def get_hotels(params, lat, lng)
    amadeus = Amadeus::Client.new({hostname: :production,
      client_id: Rails.application.credentials.client_id,
      client_secret: Rails.application.credentials.client_secret
    })
    begin
      response = amadeus.shopping.hotel_offers.get(latitude: lat, longitude: lng, ratings: params[:rating], radius: 3, radiusUnit: 'KM', view: 'LIGHT')
    rescue Amadeus::ResponseError => error
      return 'error'
    end
    hotels = JSON.parse(response.body)
    hotelsFinal = hotels['data'].slice(0, 3)
  end 
end