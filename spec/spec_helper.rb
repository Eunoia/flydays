require 'simplecov'
SimpleCov.start

require 'pry'
require 'flyday'
require 'timecop'
require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :webmock
end
