require 'spec_helper'

describe MollomRestApi do
  describe :attr_accessors do
    %w(url public_key private_key oauth_options).each do |config|
      describe config do
        before(:each) { @old_config = MollomRestApi.send(config) }
        after(:each) { MollomRestApi.send("#{config}=", @old_config) }

        it "should have an attr_accessor for #{config}" do
          MollomRestApi.send("#{config}=", 'test')
          expect(MollomRestApi.send(config)).to eq('test')
        end
      end
    end
  end

  describe :oauth_access_token do
    let(:oauth_access_token) { MollomRestApi.oauth_access_token }

    it "should return a oauth access token" do
      expect(oauth_access_token).to be_a(OAuth::AccessToken)

      expect(oauth_access_token.consumer).to be_a(OAuth::Consumer)
      expect(oauth_access_token.consumer.key).to eq('my_public_key')
      expect(oauth_access_token.consumer.secret).to eq('my_private_key')
      expect(oauth_access_token.consumer.options).to include(proxy: 'http://proxy.com:8888')
    end
  end
end