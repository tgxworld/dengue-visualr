class Geocoder
  URL = "https://maps.googleapis.com"

  class << self
    def geocode(address, format='json')
      connection = Faraday.new(url: URL)

      connection.get do |request|
        request.url "/maps/api/geocode/#{format}", address: address,
          key: Rails.application.secrets[:google_api_server_key]
      end
    end

    def coordinates(address)
      json = JSON.parse(self.geocode(address).body)
      coordinates = json["results"].first["geometry"]["location"]
    end
  end
end
