class MapquestService

  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/")
  end

  # def self.get_location(lat, lon)
  #   response = conn.get("address?key=#{Rails.application.credentials.mapquest_api[:key]}&location=#{lat},#{lon}")
  #   hash = JSON.parse(response.body, symbolize_names: true)
  # end

  def self.get_lat_lon(location)
    response = conn.get("address?key=#{Rails.application.credentials.mapquest_api[:key]}&location=#{location}")
    hash = JSON.parse(response.body, symbolize_names: true)
    hash[:results].first[:locations].first[:latLng]
  end 

  def self.get_travel_data(origin, destination)
    response = conn.get("address?key=#{Rails.application.credentials.mapquest_api[:key]}&location=#{destination}")
    hash = JSON.parse(response.body, symbolize_names: true)
    hash[:results].first[:locations].first[:latLng]
  end 

end