class MollomRestApi::V1::Feedback < MollomRestApi::Interface
  class << self
    def create(reason, request_parameters = {})
      raise_missing_parameter_error unless request_parameters.include?(:contentId) ^ request_parameters.include?(:captchaId)
      post(request_parameters.reverse_merge(reason: reason))
    end

    private

    def raise_missing_parameter_error
      raise ArgumentError.new("Specify one of two parameters: contentId or captchaId.")
    end
  end
end