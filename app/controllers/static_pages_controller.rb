class StaticPagesController < ApplicationController
  def homepage
    # FIXME: This shouldn't be here
    dropbox_client = DropboxClient.new(Rails.application.secrets[:dropbox_access_token])
    metadata = dropbox_client.metadata('/')

    @last_data = metadata['contents'].first['path']
      .scan(/(\d{2})_(\d{2})_(\d{4})/).first

    @last_data_date = @last_data.join('_')
  end
end
