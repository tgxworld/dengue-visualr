require 'csv'

class DengueDataParser
  class << self
    def parse(contents)
      data = CSV.parse(contents)
      data.shift

      data = data.map do |d|
        location, latitude, longitude, cases = d

        { location: location, latitude: latitude, longitude: longitude, number_of_cases: cases }
      end

      data.reject! { |d| d[:location].empty? }
      data
    end
  end
end
