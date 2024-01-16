require 'rails_helper'

RSpec.describe "Users Create" do
  it "Post request for users create" do
    new_user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post "/api/v0/users", params: new_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(201)

    json_response = JSON.parse(response.body, symbolize_names: true)
    data = json_response[:data]
    expect(data).to be_a Hash

    expect(data.keys.count).to eq(3)
    expect(data[:id].to_i).to_not eq(0)
    expect(data[:type]).to eq("user")
    attributes = data[:attributes]
    expect(attributes).to be_a Hash

    expect(attributes.keys.count).to eq(2)
    expect(attributes[:email]).to be_a String
    expect(attributes[:api_key]).to be_a String
    expect(attributes[:api_key].length).to eq(22)
  end

  it "Post request for users create sad path duplicate email" do
    new_user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post "/api/v0/users", params: new_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    post "/api/v0/users", params: new_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    json_response = JSON.parse(response.body, symbolize_names: true)
    errors = json_response[:errors]
    expect(errors).to be_a Array
    expect(errors.first).to be_a Hash
    expect(errors.first[:detail]).to eq("Validation failed: Email has already been taken")
  end

  it "Post request for users create sad path non-matching passwords" do
    new_user = {
      "email": "whatever@example.com",
      "password": "password1",
      "password_confirmation": "password"
    }

    post "/api/v0/users", params: new_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    json_response = JSON.parse(response.body, symbolize_names: true)
    errors = json_response[:errors]
    expect(errors).to be_a Array
    expect(errors.first).to be_a Hash
    expect(errors.first[:detail]).to eq("Validation failed: Password confirmation doesn't match Password")
  end

  it "Post request for users create sad path non-matching passwords" do
    new_user = {
      "email": "whatever@example.com",
      "password": "password1"
    }

    post "/api/v0/users", params: new_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    json_response = JSON.parse(response.body, symbolize_names: true)
    errors = json_response[:errors]
    expect(errors).to be_a Array
    expect(errors.first).to be_a Hash
    expect(errors.first[:detail]).to eq("Validation failed: Password confirmation can't be blank")
  end
end