require 'test_helper'

class DengueDataParserTest < ActiveSupport::TestCase
  setup do
    @contents = "HEADER,HEADER,HEADER\nMY ROAD,1,2\nYOUR ROAD,2,3"
  end

  def test_parse
    expected = [
      { location: 'MY ROAD', latitude: '1', longitude: '2' },
      { location: 'YOUR ROAD', latitude: '2', longitude: '3' }
    ]

    assert_equal expected, DengueDataParser.parse(@contents)
  end
end
