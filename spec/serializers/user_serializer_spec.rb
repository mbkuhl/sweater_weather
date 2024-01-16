require 'rails_helper'

RSpec.describe UserSerializer do
  it 'can make a json style hash given a user object', :vcr do
    new_user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    user = User.create!(email: new_user[:email], password: new_user[:password], password_confirmation: new_user[:password_confirmation])

    user = User.all.first

    hash = UserSerializer.new(user).to_hash

    data = hash[:data]
    expect(data).to be_a Hash
    expect(data.keys.count).to eq(3)
    expect(data[:id].to_i).to_not eq(0)
    expect(data[:type].to_s).to eq("user")
    attributes = data[:attributes]
    expect(attributes).to be_a Hash

    expect(attributes.keys.count).to eq(2)
    expect(attributes[:email]).to be_a String
    expect(attributes[:api_key]).to be_a String
    expect(attributes[:api_key].length).to eq(22)
  end
end