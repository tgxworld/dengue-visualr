require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = Rails.root.join('test', 'vcr_cassettes')
  c.hook_into :webmock
end
