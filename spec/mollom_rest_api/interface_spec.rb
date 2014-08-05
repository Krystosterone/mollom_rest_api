require 'spec_helper'

describe MollomRestApi::Interface do
  describe :api_method, vcr: {cassette_name: 'interface/some_api/action'} do
    it "should call the correct url using the method name" do
      expect(MollomRestApi::VTest01::Ticket.an_action).to eq('Valid response.')
    end

    include_examples "api error handling", class_under_test: MollomRestApi::VTest01::Ticket, method_under_test: :an_action
  end

  describe :api_method, vcr: {cassette_name: 'interface/some_api/another_action'} do
    it "should call the correct url using the overriden properties in the method" do
      expect(MollomRestApi::VTest01::Ticket.another_action).to eq('Valid response.')
    end

    include_examples "api error handling", class_under_test: MollomRestApi::VTest01::Ticket, method_under_test: :another_action
  end
end