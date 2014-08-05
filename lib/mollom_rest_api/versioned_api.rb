module MollomRestApi
  class VersionedApi
    class << self
      def method_missing(method_name, *arguments, &block)
        if handles_api_call?(method_name)
          target_class = extract_class_from(method_name)
          target_method = extract_method_from(method_name)
          target_class.send(target_method, *arguments)
        else
          super
        end
      end

      def respond_to?(method_name, include_private = false)
        if handles_api_call?(method_name)
          true
        else
          super
        end
      end

      private

      def handles_api_call?(method_name)
        target_class = extract_class_from(method_name)
        return false if target_class.nil?

        target_method = extract_method_from(method_name)
        target_class.respond_to?(target_method)
      end

      def extract_class_from(method_name)
        interface_name = method_name.to_s.split('_').last
        class_name = interface_name.camelize
        return unless self.const_defined?(class_name)

        target_class_name = "#{self.name}::#{class_name}"
        target_class_name.constantize
      end

      def extract_method_from(method_name)
        method_name.to_s.split('_').first
      end
    end
  end
end