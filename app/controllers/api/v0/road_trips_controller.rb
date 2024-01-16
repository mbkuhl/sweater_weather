class Api::V0::RoadTripsController < ApplicationController

  def show
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = RoadTripFacade.get_road_trip(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: ErrorSerializer.new(ErrorMessage.new("Invalid API key", 401)).error_json, status: :unauthorized
    end
  end

end