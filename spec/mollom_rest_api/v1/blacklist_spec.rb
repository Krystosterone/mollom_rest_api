require "spec_helper"

describe MollomRestApi::V1::Blacklist do

  describe :create do
    context "when providing a valid url and email", vcr: {cassette_name: "blacklist/create"} do
      let(:request_parameters) { {context: 'allFields'} }
      let(:response) {{"context"=>"allFields", "created"=>"1409677772829", "id"=>"41a0e033-3d6a-465b-87d5-1ef60476da62", "match"=>"contains", "note"=>"", "reason"=>"unwanted", "status"=>"1", "value"=>"text"}}

      it "should return a json response containing the blacklist entry" do
        expect(MollomRestApi::V1::Blacklist.create('1lgj17lzuezlu1bn9ry4k3qz4k8nr42n', 'text', request_parameters)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Blacklist, method_under_test: :create, method_args: ['ABC', 'DEF']
  end

end