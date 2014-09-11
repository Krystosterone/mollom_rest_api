require 'mollom_rest_api'
require 'fixtures/v_test_01'
Dir["./spec/support/**/*.rb"].sort.each { |f| require f}

require 'coveralls'
Coveralls.wear!

RSpec.configure do |c|
  c.before(:all) do
    MollomRestApi.url = 'http://dev.mollom.com'
    MollomRestApi.public_key = 'my_public_key'
    MollomRestApi.private_key = 'my_private_key'
    MollomRestApi.oauth_options = {proxy: 'http://proxy.com:8888'}
  end
end