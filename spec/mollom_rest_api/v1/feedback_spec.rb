require "spec_helper"

describe MollomRestApi::V1::Feedback do
  describe :add do
    context "when no contentId or captchaId is specified" do
      it "should raise an argument error" do
        expect{MollomRestApi::V1::Feedback.add("spam")}.to raise_exception do |exception|
          expect(exception).to be_a(ArgumentError)
          expect(exception.message).to eq("Specify one of two parameters: contentId or captchaId.")
        end
      end
    end

    context "when any contentId is specified (valid or invalid)", vcr: {cassette_name: "feedback/add/content_request"} do
      it "should have silently passed" do
        expect(MollomRestApi::V1::Feedback.add("spam", contentId: "some_id")).to be_nil
      end
    end

    context "when any captchaId is specified (valid or invalid)", vcr: {cassette_name: "feedback/add/captcha_request"} do
      it "should have silently passed" do
        expect(MollomRestApi::V1::Feedback.add("spam", captchaId: "some_id")).to be_nil
      end
    end

    context "when a contentId and a captchaId are passed" do
      it "should raise an argument error" do
        expect{MollomRestApi::V1::Feedback.add("spam", captchaId: "one", contentId: "two")}.to raise_exception do |exception|
          expect(exception).to be_a(ArgumentError)
          expect(exception.message).to eq("Specify one of two parameters: contentId or captchaId.")
        end
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Content, method_under_test: :check
  end
end