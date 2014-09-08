module MollomRestApi
  class VTest01 < VersionedApi
    class Ticket < MollomRestApi::Interface
      def self.create; end

      def self.a_post_action
        post
      end

      def self.an_overriden_post_action
        post({authorId: 9}, "delete")
      end

      def self.a_get_list_action
        get
      end

      def self.an_overriden_get_action
        get({status: :active}, "list")
      end

      def self.delete
        post({}, ['a_path_parameter'])
      end
    end
  end
end