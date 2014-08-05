class MollomRestApi::V1::Captcha < MollomRestApi::Interface
  def self.create(type = 'image', request_parameters = {})
    post(request_parameters.reverse_merge(type: type))
  end

  def self.verify(captcha_id, solution, request_parameters = {})
    post(request_parameters.reverse_merge(solution: solution), captcha_id)
  end
end