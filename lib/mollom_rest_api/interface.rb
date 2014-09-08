class MollomRestApi::Interface
  REQUEST_HEADERS = {'Accept' => 'application/json'}
  MANDATORY_CONFIGURATIONS = %w(url public_key private_key)

  class << self
    protected

    def results_key
      path_from_class_name
    end

    def path
      path_from_class_name
    end

    def version
      version_from_class_name
    end

    def post(request_parameters = {}, path_parameters = [])
      request(:post, request_parameters, path_parameters)
    end

    def get(request_parameters = {}, path_parameters = [])
      request(:get, request_parameters, path_parameters)
    end

    private

    def request(http_method, request_parameters, path_parameters)
      ensure_configuration_is_valid!

      request_arguments = request_arguments(http_method, path, path_parameters, request_parameters, version)
      response = MollomRestApi.oauth_access_token.request(http_method, *request_arguments)

      throw_api_exception_using(response) unless response.code == '200'

      computed_results_key = path_parameters.empty? && http_method == :get ? 'list' : results_key
      JSON.parse(response.body)[computed_results_key]
    end

    def ensure_configuration_is_valid!
      MANDATORY_CONFIGURATIONS.each do |config|
        raise MollomRestApi::MissingConfig.new("Missing #{config}.") if MollomRestApi.send(config).nil?
      end
    end

    def request_arguments(http_method, path, path_parameters, request_parameters, version)
      url = url(path_parameters, version, path)

      if http_method == :get
        ["#{url}?#{request_parameters.to_query}", REQUEST_HEADERS]
      elsif http_method == :post
        [url, request_parameters, REQUEST_HEADERS]
      end
    end

    def url(path_parameters, version, path)
      path_parameters << 'delete' if method_that_called_the_api_operation == 'delete'
      url_path = [path, path_parameters].flatten.compact.join('/')
      "#{MollomRestApi.url}/#{version}/#{url_path}"
    end

    def method_that_called_the_api_operation
      method_nesting_level = 4
      caller[method_nesting_level][/`([^']*)'/, 1]
    end

    def version_from_class_name
      self.name.split('::')[-2].downcase
    end

    def path_from_class_name
      self.name.split('::').last.underscore
    end

    def throw_api_exception_using(response)
      raise MollomRestApi::ApiException.new(response.body, response.code.to_i)
    end
  end
end