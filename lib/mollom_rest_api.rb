require 'oauth'
require 'json'
require 'active_support/all'

module MollomRestApi
  require 'mollom_rest_api/version'
  require 'mollom_rest_api/exceptions'
  require 'mollom_rest_api/interface'
  require 'mollom_rest_api/versioned_api'
  require 'mollom_rest_api/v1'
  require 'mollom_rest_api/v1/content'
  require 'mollom_rest_api/v1/captcha'
  require 'mollom_rest_api/v1/feedback'
  require 'mollom_rest_api/v1/site'

  class << self
    attr_accessor :url, :public_key, :private_key, :oauth_options

    def oauth_access_token
      @oauth_access_token ||= OAuth::AccessToken.new(oauth_consumer)
    end

    private

    def oauth_consumer
      OAuth::Consumer.new(public_key, private_key, @oauth_options || {})
    end
  end
end