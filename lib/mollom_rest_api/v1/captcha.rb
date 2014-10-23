class MollomRestApi::V1::Captcha < MollomRestApi::Interface
  class << self
    def create(type = 'image', request_parameters = {})
      post(request_parameters.reverse_merge(type: type))
    end

    def verify(captcha_id, solution, request_parameters = {})
      post(request_parameters.reverse_merge(solution: solution), captcha_id)
    end
  end
end