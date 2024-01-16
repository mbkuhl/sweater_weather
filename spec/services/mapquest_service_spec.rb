require 'rails_helper'

RSpec.describe 'API call' do
  it 'gets lat and lon data for a given city and state', :vcr do
    data = MapquestService.get_lat_lon("houston,tx")

    expect(data).to be_a(Hash)
    expect(data).to have_key(:lat)
    expect(data[:lat]).to be_a Float
    expect(data).to have_key(:lng)
    expect(data[:lng]).to be_a Float
    expect(data.keys.count).to eq(2)

  end

  it 'gets travel time in various formats given two cities in a certain format', :vcr do
    travel_time = MapquestService.get_travel_time("cincinatti,oh", "chicago,il")

    expect(travel_time).to be_a(Hash)

    expect(travel_time.keys.count).to eq(6)
    expect(travel_time).to have_key(:formatted_time)
    expect(travel_time[:formatted_time]).to be_a String
    expect(travel_time).to have_key(:time_in_sec)
    expect(travel_time[:time_in_sec]).to be_a Integer
    expect(travel_time).to have_key(:hr)
    expect(travel_time[:hr]).to be_a String
    expect(travel_time).to have_key(:min)
    expect(travel_time[:min]).to be_a String
    expect(travel_time).to have_key(:sec)
    expect(travel_time[:sec]).to be_a String
    expect(travel_time).to have_key(:day)
    expect(travel_time[:day]).to be nil
  end

  it 'returns error given a non drivable route', :vcr do
    travel_time = MapquestService.get_travel_time("cincinatti,oh", "london,uk")

    expect(travel_time).to eq({:routeError=>{:errorCode=>2, :message=>""}})
  end
end