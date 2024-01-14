require 'rails_helper'

RSpec.describe 'API call' do
  it 'gets a clean forecast hash without extra data given a lat and lon', :vcr do
    data = WeatherService.get_forecast(29.76078, 95.36952)

    expect(data).to be_a(Hash)

    expect(data).to have_key(:current_weather)
    expect(data[:current_weather]).to be_a(Hash)
    expect(data[:current_weather].keys.count).to eq(8)
    expect(data[:current_weather]).to have_key(:last_updated)
    expect(data[:current_weather][:last_updated]).to be_a String
    expect(data[:current_weather]).to have_key(:temperature)
    expect(data[:current_weather][:temperature]).to be_a Float
    expect(data[:current_weather]).to have_key(:feels_like)
    expect(data[:current_weather][:feels_like]).to be_a Float
    expect(data[:current_weather]).to have_key(:humidity)
    expect(data[:current_weather][:humidity]).to be_a Integer
    expect(data[:current_weather]).to have_key(:uvi)
    expect(data[:current_weather][:uvi]).to be_a Float
    expect(data[:current_weather]).to have_key(:visibility)
    expect(data[:current_weather][:visibility]).to be_a Float
    expect(data[:current_weather]).to have_key(:condition)
    expect(data[:current_weather][:condition]).to be_a String
    expect(data[:current_weather]).to have_key(:icon)
    expect(data[:current_weather][:icon]).to be_a String

    expect(data).to have_key(:daily_weather)
    expect(data[:daily_weather]).to be_a(Array)
    expect(data[:daily_weather].count).to eq(5)
    data[:daily_weather].each do |day|
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

    expect(data).to have_key(:hourly_weather)
    expect(data[:hourly_weather]).to be_a(Array)
    expect(data[:hourly_weather].count).to eq(24)
    data[:hourly_weather].each do |hour|
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