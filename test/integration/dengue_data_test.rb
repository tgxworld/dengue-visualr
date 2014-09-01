require 'test_helper'

class DengueDataTest < ActionDispatch::IntegrationTest
  setup do
    @client = stub('client')
    DropboxClient.stubs(:new).returns(@client)

    @content = "Location,Latitude,Longitude,Cases\n" \
      "My Father's Road,1,2,3\n"

    @client.stubs(:get_file_and_metadata).returns(@content)
    @expected = DengueDataParser.parse(@content)
  end

  def test_coordinates_respond_to_json
    get dengue_data_coordinates_path, format: 'json'
    assert_equal @expected.to_json, response.body
  end

  def test_coordinates_rescue_file_not_found
    error_message = 'File Not Found'
    exception = -> { raise error_message }

    @client.stubs(:get_file_and_metadata, exception) do
      assert_equal error_message, response.body
    end
  end
end
