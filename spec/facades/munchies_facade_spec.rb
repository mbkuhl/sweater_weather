require 'rails_helper'

RSpec.describe 'Makes object from input location' do
  it 'gets a munchies object with  all data for a location given as city,st', :vcr do
    munchies = MunchiesFacade.get_munchies("houston,tx", "italian")

    expect(munchies).to be_a Munchies

    expect(munchies.destination_city).to eq("Houston, TX")
    expect(munchies.id).to be nil
    expect(munchies.forecast).to be_a Hash
    expect(munchies.forecast.keys).to eq([:temperature, :summary])
    expect(munchies.forecast[:temperature]).to be_a Float
    expect(munchies.forecast[:summary]).to be_a String
    expect(munchies.restaurant).to be_a Hash
    expect(munchies.restaurant.keys).to eq([:name, :address, :rating, :reviews])
    expect(munchies.restaurant[:name]).to be_a String
    expect(munchies.restaurant[:address]).to be_a String
    expect(munchies.restaurant[:rating]).to be_a Float
    expect(munchies.restaurant[:reviews]).to be_a Integer


  end
end