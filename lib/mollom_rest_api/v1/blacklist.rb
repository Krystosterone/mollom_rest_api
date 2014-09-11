class MollomRestApi::V1::Blacklist < MollomRestApi::Interface

  def self.create(public_key, value, request_parameters = {})
    post(request_parameters.reverse_merge(value: value), [public_key])
  end

  def self.update(public_key, blacklist_entry_id, request_parameters = {})
    post(request_parameters, [public_key, blacklist_entry_id])
  end

  def self.delete(public_key, blacklist_entry_id)
    post({}, [public_key, blacklist_entry_id])
  end

  def self.list(public_key, request_parameters = {})
    get(request_parameters, [public_key])
  end

  def self.read(public_key, blacklist_entry_id)
    get({}, [public_key, blacklist_entry_id])
  end

  class << self
    protected

    def results_key
      'entry'
    end
  end
end