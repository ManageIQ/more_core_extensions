module MoreCoreExtensions
  module ObjectSafeInspect
    def self.included(_other)
      if RUBY_VERSION >= "3.5"
        warn "Ruby 3.5+ has a built-in #inspect that supports hiding instance variables with instance_variables_to_inspect, so this extension is not needed."
      end
    end

    if RUBY_VERSION < "3.5"
      #
      # Provides an alternative to #inspect that will avoid printing sensitive instance variables.
      #
      # In order to hide instance variables from inspect, you can create a method named
      # `#instance_variables_to_inspect`, returning the instance variables to inspect.
      #
      # NOTE: As this module patches the existing #inspect method, it is opt-in only and will not
      # be included via more_core_extensions/all.
      #
      def inspect
        prefix = Kernel.instance_method(:inspect).bind(self).call.split(' ', 2).first

        ivars =
          if respond_to?(:instance_variables_to_inspect)
            instance_variables_to_inspect
          elsif respond_to?(:pretty_print_instance_variables)
            pretty_print_instance_variables
          else
            instance_variables
          end
        ivars = ivars.map { |iv| "#{iv}=#{instance_variable_get(iv).inspect}" }.join(", ")

        "#{prefix}#{" " unless ivars.empty?}#{ivars}>"
      end
    end
  end
end
