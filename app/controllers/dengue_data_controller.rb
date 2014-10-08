class DengueDataController < ApplicationController
  respond_to :json

  def coordinates
    begin
      if coordinates = $redis.get(params[:filename])
        JSON.parse(coordinates)
      else
        contents, metadata = dropbox_client.get_file_and_metadata("/#{params[:filename]}.csv")
        coordinates = DengueDataParser.parse(contents)
        $redis.set(params[:filename], coordinates.to_json)
        coordinates
      end
    rescue => e
      e.message
    end

    respond_with coordinates
  end

  def dates
    respond_with $redis.get('list')
  end

  private

  def dropbox_client
    @client ||= DropboxClient.new(Rails.application.secrets[:dropbox_access_token])
  end

  def total_number_of_cases(data)
    cases = 0

    data.each do |d|
      cases += d[:number_of_cases].to_i
    end

    cases
  end
end
