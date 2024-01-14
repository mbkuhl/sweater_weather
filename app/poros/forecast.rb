class Forecast
  attr_reader :current_weather,
              :daily_weather,
              :hourly_weather,
              :id
  def initialize(forecast_data)
    @id = nil
    @current_weather = forecast_data[:current_weather]
    @daily_weather = forecast_data[:daily_weather]
    @hourly_weather = forecast_data[:hourly_weather]
  end
end