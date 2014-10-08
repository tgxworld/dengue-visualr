require 'dropbox_sdk'

class DengueDataDatesLoader
  extend DropboxGenerator

  class << self
    def load
      client = DropboxGenerator.generate_client
      metadata = client.metadata('/')
      list = {}

      metadata["contents"].each do |file|
        date = file["path"].scan(/(\d{2})_(\d{2})_(\d{4})/).first

        contents, metadata = client.get_file_and_metadata(file["path"])
        data = DengueDataParser.parse(contents)

        list[Date.new(date[2].to_i, date[1].to_i, date[0].to_i).to_time.to_i] \
          = total_number_of_cases(data)
      end
    end

    private

    def total_number_of_cases(data)
      cases = 0

      data.each do |d|
        cases += d[:number_of_cases].to_i
      end

      cases
    end
  end
end
