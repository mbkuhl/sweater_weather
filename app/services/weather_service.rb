class WeatherService

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com/v1/")
  end

  def self.get_forecast(lat, lon)
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat},#{lon}&days=5")
    hash = JSON.parse(response.body, symbolize_names: true)
    forecast_cleaner(hash)
  end

  def self.forecast_cleaner(full_hash)
    full_hash
  end
end