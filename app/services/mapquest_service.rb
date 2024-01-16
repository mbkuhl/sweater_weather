class MapquestService

  def self.conn
    Faraday.new(url: "https://www.mapquestapi.com/geocoding/v1/")
  end

  def self.dir_conn
    Faraday.new(url: "https://www.mapquestapi.com/directions/v2/")
  end

  def self.get_lat_lon(location)
    response = conn.get("address?key=#{Rails.application.credentials.mapquest_api[:key]}&location=#{location}")
    hash = JSON.parse(response.body, symbolize_names: true)
    hash[:results].first[:locations].first[:latLng]
  end 

  def self.get_travel_time(origin, destination)
    response = dir_conn.get("route?key=#{Rails.application.credentials.mapquest_api[:key]}&from=#{origin}&to=#{destination}")
    time = JSON.parse(response.body, symbolize_names: true)[:route]
    split_time = time[:formattedTime].split(":")
    { 
      formatted_time: time[:formattedTime],
      time_in_sec: time[:time],
      hr: split_time[-3],
      min: split_time[-2],
      sec: split_time[-1],
      day: split_time[-4]
    }
  end 

end