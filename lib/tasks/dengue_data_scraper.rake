require 'dropbox_sdk'

namespace :dengue do
  desc "Scrap Dengue Data"
  task :scrape => :environment do
    csv = DengueDataScraper.new('http://www.dengue.gov.sg/subject.asp?id=74').csv
    client = DropboxClient.new(Rails.application.secrets[:dropbox_access_token])
    client.put_file("/#{Time.zone.now.strftime(DengueDataScraper::FILENAME)}.csv", csv)
  end
end
