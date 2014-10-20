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

  describe :update do
    context "when providing a public key and blacklist entry id", vcr: {cassette_name: "blacklist/update"} do
      let(:request_parameters) { {value: 'patate', reason: 'profanity'} }
      let(:response) {{"context"=>"allFields", "created"=>"1409677772829", "id"=>"41a0e033-3d6a-465b-87d5-1ef60476da62", "match"=>"contains", "note"=>"", "reason"=>"profanity", "status"=>"1", "value"=>"patate"}}

      it "should return a json response containing the updated blacklist entry" do
        expect(MollomRestApi::V1::Blacklist.update('1lgj17lzuezlu1bn9ry4k3qz4k8nr42n', '42a51362-bab6-4256-8e28-60d5df568250', request_parameters)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Blacklist, method_under_test: :update, method_args: %w(public_key blacklist_entry_id)
  end

  describe :delete do
    context "when providing a public key and blacklist entry id", vcr: {cassette_name: "blacklist/delete"} do
      it "should return a json response containing the deleted blacklist entry" do
        expect{MollomRestApi::V1::Blacklist.delete('1lgj17lzuezlu1bn9ry4k3qz4k8nr42n', '42a51362-bab6-4256-8e28-60d5df568250')}.not_to raise_error
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Blacklist, method_under_test: :delete, method_args: %w(public_key blacklist_entry_id)
  end

  describe :list do
    context "when providing a public key", vcr: {cassette_name: "blacklist/list"} do
      let(:request_parameters) {{count: 5}}
      let(:response) {{"entry"=>[{"context"=>"allFields", "created"=>"1410369319158", "id"=>"eafc878d-94f7-462d-bb67-49d5170a9a71", "match"=>"contains", "note"=>"", "reason"=>"unwanted", "status"=>"1", "value"=>"patate-chaude"}, {"context"=>"allFields", "created"=>"1410369319342", "id"=>"975805c8-ee06-4750-8cda-ec5626712c50", "match"=>"contains", "note"=>"", "reason"=>"unwanted", "status"=>"1", "value"=>"system_32"}]}}

      it "should return a json response containing the list of blacklisted entries" do
        expect(MollomRestApi::V1::Blacklist.list('1lgj17lzuezlu1bn9ry4k3qz4k8nr42n', request_parameters)).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Blacklist, method_under_test: :list, method_args: %w(public_key)
  end

  describe :read do
    context "when providing a public key and blacklist entry id", vcr: {cassette_name: "blacklist/read"} do
      let(:response) {{"context"=>"allFields", "created"=>"1410452568617", "id"=>"68172853-2a81-4899-b09a-ff1f1bad88aa", "match"=>"contains", "note"=>"", "reason"=>"unwanted", "status"=>"1", "value"=>"text"}}

      it "should return a json response containing the blacklist entry" do
        expect(MollomRestApi::V1::Blacklist.read('1lgj17lzuezlu1bn9ry4k3qz4k8nr42n', '68172853-2a81-4899-b09a-ff1f1bad88aa')).to eq(response)
      end
    end

    include_examples "api error handling", class_under_test: MollomRestApi::V1::Blacklist, method_under_test: :read, method_args: %w(public_key blacklist_entry_id)
  end
end