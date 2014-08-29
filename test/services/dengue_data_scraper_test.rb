require 'test_helper'

class DengueDataScapperTest < ActiveSupport::TestCase
  def test_get_html
    data_scraper = DengueDataScraper.new('test/fixtures/views/test.html')
    assert_equal data_scraper.get_html.text, "Hello World\n"
  end
end
