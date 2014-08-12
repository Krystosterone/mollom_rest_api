require "spec_helper"

describe MollomRestApi::V1::Site do
  describe :create do
    context "when providing a valid url and email", vcr: {cassette_name: "site/create"} do
      let(:request_parameters) { {platformName: "Drupal", platformVersion: "6.20"} }
      let(:response) { {"publicKey" => "44wvtjchwxaj1h90cqi1hxscwcpceylx", "privateKey" => "ton7cjeu271j15l94ip777uvv1pcgua3", "url" => "http://url", "email" => "an-email@gmail.com", "platformName" => "Drupal", "platformVersion" => "6.20", "expectedLanguages" => nil} }

      it "should return a json response classifying the content" do
        expect(MollomRestApi::V1::Site.create("http://url", "an-email@gmail.com", request_parameters)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Site, method_under_test: :create, method_args: ['http://url', 'an-email-address@gmail.com']
  end

  describe :update do
    context 'when providing a valid public key', vcr: {cassette_name: 'site/update'} do
      let(:request_parameters) { {platformName: "Drupal", platformVersion: "6.20"} }
      let(:response) { {"publicKey"=>"1mkno2c8bsepo12ewu7v0mmpxro77o3u", "privateKey"=>"z2urchz11o21b9m76l0x51iz1ize75g0", "expectedLanguages"=>nil} }

      it 'should return the updated site ' do
        expect(MollomRestApi::V1::Site.update('1mkno2c8bsepo12ewu7v0mmpxro77o3u')).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Site, method_under_test: :update, method_args: ['a_public_key']
  end

  describe :list do
    context 'when listing the first 5 sites', vcr: {cassette_name: 'site/list'} do
      let(:request_parameters) { {count: 5} }
      let(:response) { {"site"=>[{"publicKey"=>"1cu4vdx7a6m9c1jc2425k1o9r8me2mrz", "privateKey"=>"1khj0vgpcqtjfwbbl5fr3wiykmr2ajro", "url"=>"http://url", "email"=>"an-email@gmail.com", "platformName"=>"Drupal", "platformVersion"=>"6.20", "expectedLanguages"=>nil}, {"publicKey"=>"geu7chlny71m18ve7inn41kuap9ztyja", "privateKey"=>"16o5626oykcsophjt31p1lim986rm5cq", "url"=>"http://url", "email"=>"an-email@gmail.com", "platformName"=>"Drupal", "platformVersion"=>"6.20", "expectedLanguages"=>nil}, {"publicKey"=>"44wvtjchwxaj1h90cqi1hxscwcpceylx", "privateKey"=>"ton7cjeu271j15l94ip777uvv1pcgua3", "url"=>"http://url", "email"=>"an-email@gmail.com", "platformName"=>"Drupal", "platformVersion"=>"6.20", "expectedLanguages"=>nil}]} }
      it 'should return the list of sites' do
        expect(MollomRestApi::V1::Site.list(request_parameters)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Site, method_under_test: :list
  end

  describe :read, vcr: {cassette_name: 'site/read'} do
    let(:response) { {"publicKey"=>"1cu4vdx7a6m9c1jc2425k1o9r8me2mrz", "privateKey"=>"1khj0vgpcqtjfwbbl5fr3wiykmr2ajro", "url"=>"http://url", "email"=>"an-email@gmail.com", "platformName"=>"Drupal", "platformVersion"=>"6.20", "expectedLanguages"=>nil} }

    it 'should return the site' do
      expect(MollomRestApi::V1::Site.read('1cu4vdx7a6m9c1jc2425k1o9r8me2mrz')).to eq(response)
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Site, method_under_test: :read, method_args: ['a_public_key']
  end

  describe :delete, vcr: {cassette_name: 'site/delete'} do
    it 'should delete a site' do
      expect{MollomRestApi::V1::Site.delete('1cu4vdx7a6m9c1jc2425k1o9r8me2mrz')}.not_to raise_error
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Site, method_under_test: :delete, method_args: ['a_public_key']
  end
end