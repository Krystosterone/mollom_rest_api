class MollomRestApi::Interface
  REQUEST_HEADERS = {'Accept' => 'application/json'}
  MANDATORY_CONFIGURATIONS = %w(url public_key private_key)

  class << self
    protected

    def post(request_parameters = {}, path_parameters = [], version = nil, path = nil)
      ensure_configuration_is_valid!

      version ||= version_from_class_name
      path ||= path_from_class_name
      url = url(path_parameters, version, path)

      response = MollomRestApi.oauth_access_token.post(url, request_parameters, REQUEST_HEADERS)

      throw_api_exception_using(response) unless response.code == '200'
      JSON.parse(response.body)[path]
    end

    private

    def ensure_configuration_is_valid!
      MANDATORY_CONFIGURATIONS.each do |config|
        raise MollomRestApi::MissingConfig.new("Missing #{config}.") if MollomRestApi.send(config).nil?
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