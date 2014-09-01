class DengueDataController < ApplicationController
  respond_to :json

  def coordinates
    begin
      client = DropboxClient.new(Rails.application.secrets[:dropbox_access_token])
      contents, metadata = client.get_file_and_metadata("/#{params[:filename]}.csv")
      coordinates = DengueDataParser.parse(contents)
    rescue => e
      e.message
    end

    respond_with coordinates
  end
end
