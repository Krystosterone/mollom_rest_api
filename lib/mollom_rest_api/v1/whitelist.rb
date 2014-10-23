class MollomRestApi::V1::Whitelist < MollomRestApi::Interface
  class << self
    def create(public_key, value, context, request_parameters = {})
      post(request_parameters.reverse_merge(value: value, context: context), [public_key])
    end

    def update(public_key, whitelist_entry_id, request_parameters = {})
      post(request_parameters, [public_key, whitelist_entry_id])
    end

    def delete(public_key, whitelist_entry_id)
      post({}, [public_key, whitelist_entry_id])
    end

    def list(public_key, request_parameters = {})
      get(request_parameters, [public_key])
    end

    def read(public_key, whitelist_entry_id)
      get({}, [public_key, whitelist_entry_id])
    end

    protected

    def results_key
      'entry'
    end
  end
end