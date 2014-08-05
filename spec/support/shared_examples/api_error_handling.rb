shared_examples "api error handling" do |options = {}|
  let(:class_under_test) { options.fetch(:class_under_test) }
  let(:method_under_test) { options.fetch(:method_under_test) }

  context "when there is a missing configuration" do
    MollomRestApi::Interface::MANDATORY_CONFIGURATIONS.each do |config|
      context "when there #{config} is missing" do
        before(:each) do
          @old_config = MollomRestApi.send(config)
          MollomRestApi.send("#{config}=", nil)
        end
        after(:each) { MollomRestApi.send("#{config}=", @old_config) }

        it "should raise an exception" do
          expect{class_under_test.send(method_under_test, *options[:method_args])}.to raise_exception do |exception|
            expect(exception).to be_a(MollomRestApi::MissingConfig)
            expect(exception.message).to eq("Missing #{config}.")
          end
        end
      end
    end
  end

  context "when there is an error with the api response", vcr: {cassette_name: "invalid_request", match_requests_on: [:method, :base_uri]} do
    it "should raise an exception" do
      expect{class_under_test.send(method_under_test, *options[:method_args])}.to raise_exception do |exception|
        expect(exception).to be_a(MollomRestApi::ApiException)
        expect(exception.message).to eq("{\"code\":\"401\",\"message\":\"Error.\"}")
        expect(exception.error_code).to eq(401)
      end
    end
  end
end