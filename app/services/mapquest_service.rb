class MapquestService

  def conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/")
  end

  def get(lat, lon)
    response = conn.get("address?key=#{Rails.application.credentials.mapquest_api[:key]}&location=#{lat},#{lon}")
    hash = JSON.parse(response.body, symbolize_names: true)
  end

end