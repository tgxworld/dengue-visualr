require 'csv'

class DengueDataParser
  class << self
    def parse(contents)
      data = CSV.parse(contents)
      data.shift

      data = data.map do |d|
        location, latitude, longitude = d

        { location: location, latitude: latitude, longitude: longitude }
      end

      data.reject! { |d| d[:location].empty? }
      data
    end
  end
end
