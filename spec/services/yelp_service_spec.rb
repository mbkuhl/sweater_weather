require 'rails_helper'

RSpec.describe 'API call', :vcr do
  it 'gets restaurant data for a location', :vcr do
    restaurant = YelpService.get_restaurant("deli", 37.786882, -122.399972)
    expect(restaurant).to be_a Hash
    expect(restaurant.keys.count).to eq 4
    expect(restaurant).to have_key(:name)
    expect(restaurant[:name]).to be_a String
    expect(restaurant).to have_key(:address)
    expect(restaurant[:address]).to be_a String
    expect(restaurant).to have_key(:rating)
    expect(restaurant[:rating]).to be_a Float
    expect(restaurant).to have_key(:reviews)
    expect(restaurant[:reviews]).to be_a Integer
  end
end