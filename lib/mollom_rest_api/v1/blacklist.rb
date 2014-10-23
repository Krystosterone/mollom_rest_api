class MollomRestApi::V1::Blacklist < MollomRestApi::Interface
  class << self
    def create(public_key, value, request_parameters = {})
      post(request_parameters.reverse_merge(value: value), [public_key])
    end

    def update(public_key, blacklist_entry_id, request_parameters = {})
      post(request_parameters, [public_key, blacklist_entry_id])
    end

    def delete(public_key, blacklist_entry_id)
      post({}, [public_key, blacklist_entry_id])
    end

    def list(public_key, request_parameters = {})
      get(request_parameters, [public_key])
    end

    def read(public_key, blacklist_entry_id)
      get({}, [public_key, blacklist_entry_id])
    end

    protected

    def results_key
      'entry'
    end
  end
end