class WeatherService

  def conn
    Faraday.new(url: "http://api.weatherapi.com/v1/")
  end

  def get_details(lat, lon, date)
    response = conn.get("history.json?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat},#{lon}&dt=#{date}")
    hash = JSON.parse(response.body, symbolize_names: true)
    if hash[:error]
      hash.to_json
    else
      { 
        location: hash[:location],
        weather_data: hash[:forecast][:forecastday].first[:day]
      }.to_json
    end
  end
end