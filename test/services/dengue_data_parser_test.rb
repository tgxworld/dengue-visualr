require 'test_helper'

class DengueDataParserTest < ActiveSupport::TestCase
  setup do
    @contents = "HEADER,HEADER,HEADER\nMY ROAD,1,2,5\nYOUR ROAD,2,3,5"
  end

  def test_parse
    expected = [
      { location: 'MY ROAD', latitude: '1', longitude: '2', number_of_cases: '5' },
      { location: 'YOUR ROAD', latitude: '2', longitude: '3', number_of_cases: '5' }
    ]

    assert_equal expected, DengueDataParser.parse(@contents)
  end
end
