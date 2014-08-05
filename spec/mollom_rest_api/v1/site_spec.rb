require "spec_helper"

describe MollomRestApi::V1::Site do
  describe :create do
    context "when providing a valid url and email", vcr: {cassette_name: "site/create"} do
      let(:request_parameters) {{platformName: "Drupal", platformVersion: "6.20"}}
      let(:response) {{"publicKey"=>"44wvtjchwxaj1h90cqi1hxscwcpceylx", "privateKey"=>"ton7cjeu271j15l94ip777uvv1pcgua3", "url"=>"http://url", "email"=>"an-email@gmail.com", "platformName"=>"Drupal", "platformVersion"=>"6.20", "expectedLanguages"=>nil}}

      it "should return a json response classifying the content" do
        expect(MollomRestApi::V1::Site.create("http://url", "an-email@gmail.com", request_parameters)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Site, method_under_test: :create, method_args: ['http://url', 'an-email-address@gmail.com']
  end
end