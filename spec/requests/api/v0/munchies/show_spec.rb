require 'rails_helper'

RSpec.describe "Munchies Show" do
  it "Get request for munchies show", :vcr do
    get "/api/v1/munchies?destination=pueblo,co&food=italian"
    expect(response).to be_successful
    
    json_response = JSON.parse(response.body, symbolize_names: true)

    expect(json_response).to be_a Hash
    expect(json_response[:data]).to be_a Hash
    expect(json_response[:data][:id]).to be nil
    expect(json_response[:data][:type]).to eq("munchies")
    data = json_response[:data][:attributes]
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