module AlternateSyntaxMacro
  module ExampleGroupMethods
    def it_should_provide_an_alternate_syntax_to_api_calls
      available_apis = described_class.constants

      available_apis.each do |api|
        class_name = "#{described_class.name}::#{api}"
        target_class = class_name.constantize
        class_methods = receiver_public_methods_of(target_class)

        class_methods.each do |action|
          alternate_syntax = "#{action}_#{api.downcase}"

          describe alternate_syntax do
            it "should call #{class_name}.#{action}" do
              expect(target_class).to receive(action).once
              described_class.send(alternate_syntax)
            end

            it "should specify that it responds to that method" do
              expect(described_class).to respond_to(alternate_syntax)
            end
          end
        end
      end
    end

    private

    def receiver_public_methods_of(klass)
      klass.public_methods(false) & klass.methods(false)
    end
  end

  def self.included(receiver)
    receiver.extend ExampleGroupMethods
  end
end