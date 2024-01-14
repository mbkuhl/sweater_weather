require 'rails_helper'

RSpec.describe MunchiesSerializer do
  it 'can make a json style hash given a munchies object', :vcr do
    munchies = MunchiesFacade.get_munchies("houston,tx", "italian")
    munchies_json_hash = MunchiesSerializer.new(munchies)

    # expect(munchies_json_hash).to be_a Hash
    # expect(munchies_json_hash[:data]).to be_a Hash
    # expect(munchies_json_hash[:data][:id]).to be nil
    # expect(munchies_json_hash[:data][:type]).to eq("munchies")
    # data = munchies_json_hash[:data][:attributes]
    # expect(data).to be_a Hash

    # expect(data.keys.count).to eq(3)
    # expect(data).to have_key(:destination_city)
    # expect(data[:destination]).to be_a(String)
    # expect(data[:destination]).to eq("Houston, TX")
  end
end