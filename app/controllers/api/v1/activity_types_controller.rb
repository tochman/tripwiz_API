# frozen_string_literal: true

class Api::V1::ActivityTypesController < ApplicationController
  def create
    @number = params[:number]
    @activity_type = ActivityType.create(activity_type: params[:activity_type], trip_id: params[:trip])

    if @activity_type.persisted?
      response = create_activities

      if response.length == @number.to_i
        render json: @activity_type, status: 200
      else
        @activity_type.destroy
        render json: { error: trip.errors.full_messages }, status: 422
      end
    end
  end

  private

  def create_activities
    activities = []
    response = get_activities

    if response['results'].length >= @number.to_i
      (0..@number.to_i - 1).each do |i|
        name = response['results'][i]['name']
        rating = response['results'][i]['rating']
        address = response['results'][i]['vicinity']
        lat = response['results'][i]['geometry']['location']['lat']
        lng = response['results'][i]['geometry']['location']['lng']
        
        activity = Activity.create(
          name: name,
          address: address,
          rating: rating,
          lat: lat,
          lng: lng,
          activity_type_id: @activity_type.id
        )
        activities << activity
      end

      return activities
    else
      return nil
    end
  end

  def get_activities
    radius = 1000
    lat = @activity_type.trip.lat
    lng = @activity_type.trip.lng

    url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
    response = JSON.parse RestClient.get url,
                                         params: { location: "#{lat},#{lng}",
                                                   type: @activity_type.activity_type,
                                                   radius: radius,
                                                   key: Rails.application.credentials.google_api_token }
  end
end
