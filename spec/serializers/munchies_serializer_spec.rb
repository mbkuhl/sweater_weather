require 'rails_helper'

RSpec.describe MunchieSerializer do
  it 'can make a json style hash given a munchies object', :vcr do
    munchies = MunchiesFacade.get_munchies("houston,tx", "italian")
    munchies_json_hash = MunchieSerializer.new(munchies)

    expect(munchies_json_hash).to be_a Hash
    expect(munchies_json_hash[:data]).to be_a Hash
    expect(munchies_json_hash[:data][:id]).to be nil
    expect(munchies_json_hash[:data][:type]).to eq("munchies")
    data = munchies_json_hash[:data][:attributes]
    expect(data).to be_a Hash

    expect(data.keys.count).to eq(3)
    expect(data).to have_key(:destination_city)
    expect(data[:destination_city]).to be_a(String)
    expect(data[:destination_city]).to eq("Pueblo, CO")

    expect(data).to have_key(:forecast)
    expect(data[:forecast]).to be_a(Hash)
    expect(data[:forecast].keys).to eq([:temperature, :summary])
    expect(data[:forecast][:temperature]).to be_a String
    expect(data[:forecast][:summary]).to be_a String

    expect(data).to have_key(:restaurant)
    expect(data[:restaurant]).to be_a(Hash)
    expect(data[:restaurant].keys).to eq([:name, :address, :rating, :reviews])
    expect(data[:restaurant][:name]).to be_a String
    expect(data[:restaurant][:address]).to be_a String
    expect(data[:restaurant][:rating]).to be_a Float
    expect(data[:restaurant][:reviews]).to be_a Integer
  end
end