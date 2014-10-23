require 'spec_helper'

describe MollomRestApi::Interface do
  describe 'a simple post action', vcr: {cassette_name: 'interface/some_api/a_post_action'} do
    it "should call the correct url using the method name" do
      expect(MollomRestApi::VTest01::Ticket.a_post_action).to eq('Valid response.')
    end

    include_examples "api error handling", class_under_test: MollomRestApi::VTest01::Ticket, method_under_test: :a_post_action
  end

  describe 'a post action with all arguments specified', vcr: {cassette_name: 'interface/some_api/an_overriden_post_action'} do
    it "should call the correct url using the overriden properties in the method" do
      expect(MollomRestApi::VTest01::Ticket.an_overriden_post_action).to eq('Valid response.')
    end

    include_examples "api error handling", class_under_test: MollomRestApi::VTest01::Ticket, method_under_test: :an_overriden_post_action
  end

  describe 'a get action with all arguments specified', vcr: {cassette_name: 'interface/some_api/an_overriden_get_action'} do
    it "should call the correct url using the overriden properties in the method" do
      expect(MollomRestApi::VTest01::Ticket.an_overriden_get_action).to eq('Valid response.')
    end

    include_examples "api error handling", class_under_test: MollomRestApi::VTest01::Ticket, method_under_test: :an_overriden_get_action
  end

  describe 'a get action to fetch a list', vcr: {cassette_name: 'interface/some_api/list'} do
    it "should call the correct url using the method name" do
      expect(MollomRestApi::VTest01::Ticket.list).to eq('Valid response.')
    end

    include_examples "api error handling", class_under_test: MollomRestApi::VTest01::Ticket, method_under_test: :list
  end

  describe 'a delete action on a resource', vcr: {cassette_name: 'interface/some_api/delete'} do
    it "should call the delete url on the resource" do
      expect(MollomRestApi::VTest01::Ticket.delete).to eq('Valid response.')
    end

    include_examples "api error handling", class_under_test: MollomRestApi::VTest01::Ticket, method_under_test: :delete
  end
end