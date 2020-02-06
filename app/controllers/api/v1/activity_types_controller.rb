class Api::V1::ActivityTypesController < ApplicationController

  def create
    activity_type = ActivityType.create(activity_type: params[:activity_type], trip_id: params[:trip])

    if activity_type.persisted?
      binding.pry
      response = new_activity_path(activity_type, trip)

      if response.status == 200
        render json: activity_type
      else
        activity_type.destroy
        render json: { error: trip.errors.full_messages }, status: 422
      end
    end
  end
end
