require 'dropbox_sdk'

module DropboxGenerator
  def self.generate_client
    DropboxClient.new(Rails.application.secrets[:dropbox_access_token])
  end
end
