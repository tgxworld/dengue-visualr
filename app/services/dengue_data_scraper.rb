require 'nokogiri'
require 'open-uri'
require 'csv'
require 'geocoder'

class DengueDataScraper
  COLUMNS = %w{
    Location
    Latitude
    Longitude
    Number\ of\ Cases
  }

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

          coordinates = Geocoder.coordinates("#{location}, Singapore")
          csv << [location, coordinates.try(:first), coordinates.try(:last), number_of_cases]
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
