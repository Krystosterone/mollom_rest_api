require "spec_helper"

describe MollomRestApi::V1::Whitelist do
  describe :create do
    context "when providing a valid url and email", vcr: {cassette_name: "whitelist/create"} do
      let(:request_parameters) { {note: 'patate'} }
      let(:response) {{"context"=>"authorIp", "created"=>"1412787909465", "id"=>"76747", "lastMatch"=>"0", "matchCount"=>"0", "status"=>"1", "value"=>"123.123.80.22"}}

      it "should return a json response containing the whitelist entry" do
        expect(MollomRestApi::V1::Whitelist.create('1lgj17lzuezlu1bn9ry4k3qz4k8nr42n', '123.123.80.22', 'authorIp', request_parameters)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Whitelist, method_under_test: :create, method_args: %w(public_key value context)
  end

  describe :update do
    context "when providing a public key and a value for an author name", vcr: {cassette_name: "whitelist/update"} do
      let(:request_parameters) { {value: 'patate', context: 'authorName'} }
      let(:response) {{"context"=>"authorName", "created"=>"1412787909465", "id"=>"76747", "lastMatch"=>"0", "matchCount"=>"0", "status"=>"0", "value"=>"patate"}}

      it "should return a json response containing the updated whitelist entry" do
        expect(MollomRestApi::V1::Whitelist.update('1lgj17lzuezlu1bn9ry4k3qz4k8nr42n', '76747', request_parameters)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Whitelist, method_under_test: :update, method_args: %w(public_key whitelist_entry_id)
  end

  describe :delete do
    context "when providing a public key and whitelist entry id", vcr: {cassette_name: "whitelist/delete"} do
      it "should return a json response containing the deleted whitelist entry" do
        expect{MollomRestApi::V1::Whitelist.delete('1lgj17lzuezlu1bn9ry4k3qz4k8nr42n', '79552')}.not_to raise_error
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Whitelist, method_under_test: :delete, method_args: %w(public_key whitelist_entry_id)
  end

  describe :list do
    context "when providing a public key", vcr: {cassette_name: "whitelist/list"} do
      let(:request_parameters) { {count: 5} }
      let(:response) {{"entry"=>{"context"=>"authorName", "created"=>"1412787909465", "id"=>"76747", "lastMatch"=>"0", "matchCount"=>"0", "status"=>"0", "value"=>"patate"}}}

      it "should return a json response containing the list of whitelist entries" do
        expect(MollomRestApi::V1::Whitelist.list('1lgj17lzuezlu1bn9ry4k3qz4k8nr42n', request_parameters)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Whitelist, method_under_test: :list, method_args: %w(a_public_key)
  end

  describe :read do
    context "when providing a public key and whitelist entry id", vcr: {cassette_name: "whitelist/read"} do
      let(:response) {{"context"=>"authorName", "created"=>"1413826721455", "id"=>"79557", "lastMatch"=>"0", "matchCount"=>"0", "status"=>"1", "value"=>"patate"}}

      it "should return a json response containing the whitelist entry" do
        expect(MollomRestApi::V1::Whitelist.read('1lgj17lzuezlu1bn9ry4k3qz4k8nr42n', '79557')).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Whitelist, method_under_test: :read, method_args: %w(public_key whitelist_entry_id)
  end
end