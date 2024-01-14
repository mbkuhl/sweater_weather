class YelpService

  def self.conn
    Faraday.new(url: "https://api.yelp.com/v3/") do |faraday|
      faraday.headers["Authorization"] = Rails.application.credentials.yelp_api[:key]
    end
  end

  def self.get_restaurant(type, lat, lon)
    response = conn.get("businesses/search?term=#{type}&latitude=#{lat}&longitude=#{lon}")
    data = JSON.parse(response.body, symbolize_names: true)
    restaurant = data[:businesses].sample
    clean_hash = {
      name: restaurant[:name],
      address: restaurant[:location][:display_address].join(" "),
      rating: restaurant[:rating],
      reviews: restaurant[:review_count]
    }
  end

end