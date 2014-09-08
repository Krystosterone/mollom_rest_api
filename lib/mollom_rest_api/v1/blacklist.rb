class MollomRestApi::V1::Blacklist < MollomRestApi::Interface

  def self.create(public_key, value, request_parameters = {})
    post(request_parameters.reverse_merge(value: value), [public_key])
  end

  class << self
    protected

    def results_key
      'entry'
    end
  end
end