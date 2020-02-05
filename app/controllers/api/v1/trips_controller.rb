class Api::V1::TripsController < ApplicationController

  def create
    trip = Trip.create(name: params["destination"],
      coord_lat: params["coord_lat"],
      coord_lng: params["coord_lng"])

    if trip.persisted?
      render json: trip
    else
      render json: { error: trip.errors.full_messages }, status: 422
    end

  end

  private

  def trip_params
    params.require(:trip).permit(:name, :coord_lat, :coord_lng)
  end

end
