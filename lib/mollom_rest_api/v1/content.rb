class MollomRestApi::V1::Content < MollomRestApi::Interface
  class << self
    def create(request_parameters = {})
      post(request_parameters)
    end
    alias_method :check, :create

    def update(content_id, request_parameters = {})
      post(request_parameters, [content_id])
    end
  end
end