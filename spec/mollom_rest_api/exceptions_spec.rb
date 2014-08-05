require 'spec_helper'

describe MollomRestApi::ApiException do
  subject { MollomRestApi::ApiException.new("An error message.", 404) }

  specify { expect(subject).to be_a(StandardError) }

  describe :message do
    specify { expect(subject.message).to eq("An error message.") }
  end

  describe :error_code do
    specify { expect(subject.error_code).to eq(404) }
  end
end

describe MollomRestApi::MissingConfig do
  subject { MollomRestApi::MissingConfig.new("A missing config.") }

  specify { expect(subject).to be_a(StandardError) }

  describe :message do
    specify { expect(subject.message).to eq("A missing config.") }
  end
end