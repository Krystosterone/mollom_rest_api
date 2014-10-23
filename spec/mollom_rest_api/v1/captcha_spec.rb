require "spec_helper"

describe MollomRestApi::V1::Captcha do
  describe :create do
    context "when no type is passed", vcr: {cassette_name: "captcha/create/default_request"} do
      let(:response) {{"id"=>"TEST1wquvxygw6nkom", "url"=>"http://dev.mollom.com/v1/captcha/TEST1wquvxygw6nkom.png"}}

      it "should return the json response for an image captcha" do
        expect(MollomRestApi::V1::Captcha.create).to eq(response)
      end
    end

    context "when an invalid type is passed", vcr: {cassette_name: "captcha/create/invalid_type"} do
      let(:response) {{"id"=>"TEST1ddgajo9ldvw11", "url"=>"http://dev.mollom.com/v1/captcha/TEST1ddgajo9ldvw11.mp3"}}

      it "should return the json response for a mp3 captcha" do
        expect(MollomRestApi::V1::Captcha.create("foobar")).to eq(response)
      end
    end

    context "when an valid type is passed", vcr: {cassette_name: "captcha/create/valid_request"} do
      let(:response) {{"id"=>"TEST190gkt2utz449q", "url"=>"https://dev.mollom.com/v1/captcha/TEST190gkt2utz449q.mp3"}}

      it "should return the json response for that type of captcha" do
        expect(MollomRestApi::V1::Captcha.create("audio", ssl: 1)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Captcha, method_under_test: :create
  end

  describe :verify do
    context "when an invalid captcha id is passed", vcr: {cassette_name: "captcha/verify/invalid_captcha_id"} do
      it "should raise an exception" do
        expect{MollomRestApi::V1::Captcha.verify('inexistent_id', 'solution')}.to raise_exception do |exception|
          expect(exception).to be_a(MollomRestApi::ApiException)
          expect(exception.message).to eq("{\"code\":\"404\",\"message\":\"Captcha not found.\"}")
          expect(exception.error_code).to eq(404)
        end
      end
    end

    context "when an valid captcha id is passed" do
      context "when an invalid solution is passed", vcr: {cassette_name: "captcha/verify/invalid_solution"} do
        let(:response) {{"id"=>"TEST15yj59df1pwv01", "solved"=>"0", "reason"=>"invalid_solution is not the correct solution."}}

        it "should return the json response with an invalid captcha solution" do
          expect(MollomRestApi::V1::Captcha.verify("TEST15yj59df1pwv01", "invalid_solution")).to eq(response)
        end
      end

      context "when a valid solution is passed", vcr: {cassette_name: "captcha/verify/valid_solution"} do
        let(:response) {{"id"=>"TEST1qravn2ikcz0k1", "solved"=>"1", "reason"=>"Correct response to image captcha."}}

        it "should return the json response with a valid captcha solution" do
          expect(MollomRestApi::V1::Captcha.verify("TEST1qravn2ikcz0k1", "correct")).to eq(response)
        end
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Captcha, method_under_test: :verify, method_args: [9000, 'a_solution']
  end
end