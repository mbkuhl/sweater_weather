class WeatherService

  def self.conn
    Faraday.new(url: "http://api.weatherapi.com/v1/")
  end

  def self.get_forecast(lat, lon)
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat},#{lon}&days=5")
    hash = JSON.parse(response.body, symbolize_names: true)
    forecast_cleaner(hash)
  end

  def self.get_weather_at_eta(lat, lon, eta)
    response = conn.get("forecast.json?key=#{Rails.application.credentials.weather_api[:key]}&q=#{lat},#{lon}&days=5")
    hash = JSON.parse(response.body, symbolize_names: true)[:forecast][:forecastday]
    weather_at_eta_cleaner(hash, eta)
  end

  def self.weather_at_eta_cleaner(daily_hash, eta)
    day_difference = (eta.to_date - Date.today).to_i
    eta_weather = daily_hash[day_difference][:hour][eta.hour]
    {
      datetime: eta_weather[:time],
      temperature: eta_weather[:temp_f],
      condition: eta_weather[:condition][:text]
    }
  end

  def self.forecast_cleaner(full_hash)
    current = full_hash[:current]
    days = full_hash[:forecast][:forecastday]
    hours = full_hash[:forecast][:forecastday].first[:hour]
    clean_hash = {
      current_weather: {
        last_updated: current[:last_updated],
        temperature: current[:temp_f],
        feels_like: current[:feelslike_f],
        humidity: current[:humidity],
        uvi: current[:uv],
        visibility: current[:vis_miles],
        condition: current[:condition][:text],
        icon: current[:condition][:icon]
      },
      daily_weather: days.map do |day|
        d = day[:day]
        astro = day[:astro]
        {
          date: day[:date],
          sunrise: astro[:sunrise],
          sunset: astro[:sunset],
          max_temp: d[:maxtemp_f],
          min_temp: d[:mintemp_f],
          condition: d[:condition][:text],
          icon: d[:condition][:icon]
        }
      end,
      hourly_weather: hours.map do |hour|
        {
          time: hour[:time].split(" ")[1],
          temperature: hour[:temp_f],
          conditions: hour[:condition][:text],
          icon: hour[:condition][:icon]
        }
      end
    }
  end
end