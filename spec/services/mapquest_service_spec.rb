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
end