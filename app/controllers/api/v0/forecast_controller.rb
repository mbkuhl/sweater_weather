class Api::V0::ForecastController << ApplicationController

  def show
    wf = WeatherFacade.new
    forecast = wf.get_forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end

end

