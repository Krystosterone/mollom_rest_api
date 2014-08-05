module MollomRestApi
  class ApiException < StandardError
    attr_reader :error_code

    def initialize(message, error_code)
      super(message)
      @error_code = error_code
    end
  end

  class MissingConfig < StandardError; end
end