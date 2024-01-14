require 'rails_helper'

RSpec.describe 'Makes object from input location' do
  it 'gets a forecast object with  all data for a location given as city,st', :vcr do
    forecast = ForecastFacade.get_forecast("houston,tx")

    expect(forecast).to be_a Forecast

    expect(forecast.current_weather).to be_a Hash
    expect(forecast.current_weather.keys).to eq([:last_updated, :temperature, :feels_like, :humidity, :uvi, :visibility, :condition, :icon])
    forecast.current_weather.each do |key, value|
      expect(value).to_not be nil
    end

    expect(forecast.daily_weather).to be_a Array
    expect(forecast.daily_weather.count).to eq(5)
    forecast.daily_weather.each do |day|
      expect(day).to be_a(Hash)
      expect(day.keys.count).to eq(7)
      expect(day).to have_key(:date)
      expect(day[:date]).to be_a String
      expect(day).to have_key(:sunrise)
      expect(day[:sunrise]).to be_a String
      expect(day).to have_key(:sunset)
      expect(day[:sunset]).to be_a String
      expect(day).to have_key(:min_temp)
      expect(day[:min_temp]).to be_a Float
      expect(day).to have_key(:max_temp)
      expect(day[:max_temp]).to be_a Float
      expect(day).to have_key(:condition)
      expect(day[:condition]).to be_a String
      expect(day).to have_key(:icon)
      expect(day[:icon]).to be_a String
    end

    expect(forecast.hourly_weather).to be_a Array
    expect(forecast.hourly_weather.count).to eq(24)
    forecast.hourly_weather.each do |hour|
      expect(hour).to be_a(Hash)
      expect(hour.keys.count).to eq(4)
      expect(hour).to have_key(:time)
      expect(hour[:time]).to be_a String
      expect(hour).to have_key(:temperature)
      expect(hour[:temperature]).to be_a Float
      expect(hour).to have_key(:conditions)
      expect(hour[:conditions]).to be_a String
      expect(hour).to have_key(:icon)
      expect(hour[:icon]).to be_a String
    end
  end
end