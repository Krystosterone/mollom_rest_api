class MollomRestApi::V1::Site < MollomRestApi::Interface
  def self.create(url, email, request_parameters = {})
    post(request_parameters.reverse_merge(url: url, email: email))
  end
end