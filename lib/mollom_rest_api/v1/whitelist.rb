class MollomRestApi::V1::Whitelist < MollomRestApi::Interface

  def self.create(public_key, value, context, request_parameters = {})
    post(request_parameters.reverse_merge(value: value, context: context), [public_key])
  end

  def self.update(public_key, whitelist_entry_id, request_parameters = {})
    post(request_parameters, [public_key, whitelist_entry_id])
  end

  def self.delete(public_key, whitelist_entry_id)
    post({}, [public_key, whitelist_entry_id])
  end

  def self.list(public_key, request_parameters = {})
    get(request_parameters, [public_key])
  end

  def self.read(public_key, whitelist_entry_id)
    get({}, [public_key, whitelist_entry_id])
  end

  class << self
    protected

    def results_key
      'entry'
    end
  end

end