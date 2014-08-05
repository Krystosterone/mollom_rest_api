class MollomRestApi::V1::Feedback < MollomRestApi::Interface
  class << self
    def add(reason, request_parameters = {})
      raise_missing_parameter_error unless content_xor_captcha_id_present_in?(request_parameters)
      post(request_parameters.reverse_merge(reason: reason))
    end

    private

    def raise_missing_parameter_error
      raise ArgumentError.new("Specify one of two parameters: contentId or captchaId.")
    end

    def content_xor_captcha_id_present_in?(request_parameters)
      request_parameters.include?(:contentId) ^ request_parameters.include?(:captchaId)
    end
  end
end