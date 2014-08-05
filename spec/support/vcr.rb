require 'webmock/rspec'
require 'vcr'

module VCRHelper
  PARAMS_TO_STRIP = %w(oauth_consumer_key oauth_nonce oauth_signature)

  def strip_authorization(headers)
    headers['Authorization'] = headers['Authorization'].collect do |header|
      header.gsub(%r((#{params_to_strip})="(.*)")) { "#{$1}=\"\"" }
    end
  end

  private

  def params_to_strip
    PARAMS_TO_STRIP.join('|')
  end
end

VCR.configure do |c|
  include VCRHelper

  c.cassette_library_dir = 'spec/fixtures/cassette_library'
  c.debug_logger = File.open('log/test.log', 'w')
  c.hook_into :webmock
  c.ignore_localhost = true
  c.default_cassette_options = {record: :none, match_requests_on: [:method, :uri, :body, :headers_with_striped_auth]}
  c.configure_rspec_metadata!

  c.register_request_matcher :headers_with_striped_auth do |r1, r2|
    strip_authorization(r1.headers.to_hash) == strip_authorization(r2.headers.to_hash)
  end

  c.register_request_matcher :base_uri do |r1, r2|
    r1.uri.start_with?(r2.uri)
  end
end