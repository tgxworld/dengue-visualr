require 'csv'

class DengueDataParser
  class << self
    def parse(contents)
      data = CSV.parse(contents)
      data.shift

      data.map do |d|
        location, latitude, longitude = d

        { location: location, latitude: latitude, longitude: longitude }
      end
    end
  end
end
