require 'dropbox_sdk'

namespace :dengue do
  desc "Scrap Dengue Data"
  task :scrape => :environment do
    csv = DengueDataScraper.new('http://www.dengue.gov.sg/subject.asp?id=74').csv
    client = DropboxClient.new(Rails.application.secrets[:dropbox_access_token])
    client.put_file("/#{Time.zone.now.strftime(DengueDataScraper::FILENAME)}.csv", csv)

    # Putting this together to ensure that it runs after the data has been updated
    # everday.
    # TODO: Implement a queue.
    $redis.set('list', DengueDataDatesLoader.load.to_json)
  end
end
