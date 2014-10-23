require 'spec_helper'

describe MollomRestApi::V1 do
  include AlternateSyntaxMacro

  describe 'when calling the alternate syntax' do
    it_should_provide_an_alternate_syntax_to_api_calls
  end
end