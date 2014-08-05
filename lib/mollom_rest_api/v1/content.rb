class MollomRestApi::V1::Content < MollomRestApi::Interface
  def self.check(request_parameters = {})
    post(request_parameters)
  end

  def self.update(content_id, request_parameters = {})
    post(request_parameters, [content_id])
  end
end