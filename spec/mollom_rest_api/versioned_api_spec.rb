require 'spec_helper'

describe MollomRestApi::VersionedApi do
  describe 'when calling the alternate syntax' do
    describe :create_ticket do
      it "should call MollomRestApi::VTest01::Ticket.create" do
        expect(MollomRestApi::VTest01::Ticket).to receive(:create).once
        MollomRestApi::VTest01.create_ticket
      end

      it "should specify that it responds to that method" do
        expect(MollomRestApi::VTest01).to respond_to(:create_ticket)
      end
    end

    describe :delete_api do
      it "should try to call MollomRestApi::VTest01::Api.delete" do
        expect{MollomRestApi::VTest01.delete_api}.to raise_exception(NameError)
      end

      it "should not be able to respond to delete_api" do
        expect(MollomRestApi::VTest01).not_to respond_to(:delete_api)
      end
    end
  end
end