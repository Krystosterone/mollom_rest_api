require "spec_helper"

describe MollomRestApi::V1::Content do
  describe :check do
    context "when the api responded correctly", vcr: {cassette_name: "content/check/valid_request"} do
      let(:request_parameters) {{postTitle: "My Title", postBody: "Some text right over here!", authorName: "Jean-Luc Picard"}}
      let(:response) {{"id"=>"TEST1up51ut7qyu2b1", "spamScore"=>"0.5", "reason"=>"some secret reason", "postTitle"=>"My Title", "postBody"=>"Some text right over here!", "spamClassification"=>"unsure"}}

      it "should return a json response classifying the content" do
        expect(MollomRestApi::V1::Content.check(request_parameters)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Content, method_under_test: :check
  end

  describe :update do
    context "when the content id doesn't exist", vcr: {cassette_name: "content/update/invalid_content_id"} do
      it "should raise an exception" do
        expect{MollomRestApi::V1::Content.update('inexistent_content_id')}.to raise_exception do |exception|
          expect(exception).to be_a(MollomRestApi::ApiException)
          expect(exception.message).to eq("{\"code\":\"404\",\"message\":\"Content not found.\"}")
          expect(exception.error_code).to eq(404)
        end
      end
    end

    context "when the content id does exist", vcr: {cassette_name: "content/update/valid_request"} do
      let(:request_parameters) {{checks: "spam", postBody: "My modified body!"}}
      let(:response) {{"id"=>"TESTmh3q39o9ktwj13", "spamScore"=>"0.5", "reason"=>"some secret reason", "postBody"=>"My modified body!", "spamClassification"=>"unsure"}}

      it "should return a json response classifying the updated content" do
        expect(MollomRestApi::V1::Content.update("TESTmh3q39o9ktwj13", request_parameters)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Content, method_under_test: :update, method_args: ["some_id"]
  end
end