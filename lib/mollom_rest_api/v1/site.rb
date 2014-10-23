class MollomRestApi::V1::Site < MollomRestApi::Interface
  class << self
    def create(url, email, request_parameters = {})
      post(request_parameters.reverse_merge(url: url, email: email))
    end

    def update(public_key, request_parameters = {})
      post(request_parameters, [public_key])
    end

    def list(request_parameters = {})
      get(request_parameters)
    end

    def read(public_key)
      get({}, [public_key])
    end

    def delete(public_key)
      post({}, [public_key])
    end
  end
end