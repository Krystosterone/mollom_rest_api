module MollomRestApi
  class VTest01 < VersionedApi
    class Ticket < MollomRestApi::Interface
      def self.create; end

      def self.an_action
        post
      end

      def self.another_action
        post({authorId: 9}, "delete", "vtest02", "override")
      end
    end
  end
end