require 'nokogiri'
require 'open-uri'
require 'csv'

class DengueDataScraper
  COLUMNS = %w{
    Location
    Latitude
    Longitude
    Number\ of\ Cases
  }

  FILENAME = "%d_%m_%Y".freeze

  def initialize(uri)
    @uri = uri
  end

  def csv
    CSV.generate(write_headers: true, headers: COLUMNS) do |csv|
      self.get_table[0].css("> tr").each do |table_row|
        table_row.css("> td > table > tr").each_with_index do |sub_table_row, sub_table_row_index|
          next if sub_table_row_index == 0
          location, number_of_cases = sub_table_row.css("> td").map do |sub_table_data|
            sub_table_data.text.squish
          end

          if match_data = location.match(/\(.+\z/)
            if !match_data.nil?
              location = location.sub(match_data[0], '')
              location = "#{match_data[0]} #{location}"
            end
          end

          coordinates = Geocoder.coordinates("#{location.humanize}, SG")
          csv << [location, coordinates["lat"], coordinates["lng"], number_of_cases]
        end
      end
    end
  end

  protected

  def get_html
    Nokogiri::HTML(open(@uri))
  end

  def get_table
    get_html.css("table.MsoNormalTable")
  end
end
