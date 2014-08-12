class MollomRestApi::V1::Site < MollomRestApi::Interface
  def self.create(url, email, request_parameters = {})
    post(request_parameters.reverse_merge(url: url, email: email))
  end

  def self.update(public_key, request_parameters = {})
    post(request_parameters, [public_key])
  end

  def self.list(request_parameters = {})
    get(request_parameters)
  end

  def self.read(public_key)
    get({}, [public_key])
  end

  def self.delete(public_key)
    post({}, [public_key])
  end
end