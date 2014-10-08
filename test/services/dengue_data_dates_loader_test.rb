require 'test_helper'

class DengueDataDatesLoaderTest < ActiveSupport::TestCase
  def test_load
    VCR.use_cassette('dengue_data_dates') do
      dates = DengueDataDatesLoader.load
      assert_equal(
        # The line below is generated using data as of 8th October.
        # Just a smoke test to ensure that everything is working as expected.
        {1409500800=>597, 1412092800=>549, 1409587200=>616, 1412179200=>558, 1409673600=>608, 1412265600=>562, 1409760000=>626, 1412352000=>577, 1409846400=>404, 1412438400=>577, 1409932800=>406, 1412524800=>577, 1410019200=>406, 1412611200=>577, 1410105600=>406, 1412697600=>567, 1410192000=>379, 1410278400=>363, 1410883200=>399, 1410969600=>416, 1411056000=>462, 1411142400=>462, 1411228800=>462, 1411315200=>464, 1411401600=>448, 1411488000=>448, 1411574400=>459, 1411660800=>481, 1411747200=>498, 1411833600=>498, 1411920000=>498, 1412006400=>506},
        dates
      )
    end
  end
end
