class MollomRestApi::Interface
  REQUEST_HEADERS = {'Accept' => 'application/json'}
  MANDATORY_CONFIGURATIONS = %w(url public_key private_key)

  class << self
    protected

    def post(request_parameters = {}, path_parameters = [], version = nil, path = nil)
      request(:post, request_parameters, path_parameters, version, path)
    end

    def get(request_parameters = {}, path_parameters = [], version = nil, path = nil)
      request(:get, request_parameters, path_parameters, version, path)
    end

    private

    def request(http_method, request_parameters, path_parameters, version, path)
      ensure_configuration_is_valid!

      version ||= version_from_class_name
      path ||= path_from_class_name

      request_arguments = request_arguments(http_method, path, path_parameters, request_parameters, version)
      response = MollomRestApi.oauth_access_token.request(http_method, *request_arguments)

      throw_api_exception_using(response) unless response.code == '200'

      results_key = path_parameters.empty? && http_method == :get ? 'list' : path
      JSON.parse(response.body)[results_key]
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
      url_path = [path, path_parameters].flatten.compact.join('/')
      "#{MollomRestApi.url}/#{version}/#{url_path}"
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