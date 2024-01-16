require 'rails_helper'

RSpec.describe "Sessions Create" do
  it "Post request for sessions create" do
    new_user = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post "/api/v0/users", params: new_user.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    
    new_session = {
      "email": "whatever@example.com",
      "password": "password"
    }

    post "/api/v0/sessions", params: new_session.to_json, headers: { 'CONTENT_TYPE' => 'application/json', 'ACCEPT' => 'application/json' }
    expect(response).to be_successful
    expect(response.status).to eq(200)

    json_response = JSON.parse(response.body, symbolize_names: true)
    data = json_response[:data]
    expect(data).to be_a Hash
  end
end
