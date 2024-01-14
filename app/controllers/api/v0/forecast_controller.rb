class Api::V0::ForecastController < ApplicationController

  def show
    forecast = ForecastFacade.get_forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end

end

