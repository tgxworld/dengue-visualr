class DengueDataController < ApplicationController
  respond_to :json

  def coordinates
    begin
      contents, metadata = dropbox_client.get_file_and_metadata("/#{params[:filename]}.csv")
      coordinates = DengueDataParser.parse(contents)
    rescue => e
      e.message
    end

    respond_with coordinates
  end

  def dates
    metadata = dropbox_client.metadata('/')

    list = {}
    metadata["contents"].each do |file|
      date = file["path"].scan(/(\d{2})_(\d{2})_(\d{4})/).first

      contents, metadata = dropbox_client.get_file_and_metadata(file["path"])
      data = DengueDataParser.parse(contents)

      # This should be done by rake task
      list[Date.new(date[2].to_i, date[1].to_i, date[0].to_i).to_time.to_i] \
        = total_number_of_cases(data)
    end

    respond_with list
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
