module MoreCoreExtensions
  module StringToIWithMethod
    NUMBER_WITH_METHOD_REGEX = /^([0-9\.,]+)\.([a-z]+)$/.freeze

    # Converts to an Integer while also evaluating a method invocation
    #
    # This method is similar to #to_i, but does not support extraneous characters
    # nor bases other than 10.
    #
    #   "20".to_i_with_method           # => 20
    #   "20.percent".to_i_with_method   # => 20
    #   "20.megabytes".to_i_with_method # => 20_971_520
    #
    #   "20.0".to_i_with_method           # => 20
    #   "20.0.percent".to_i_with_method   # => 20
    #   "20.0.megabytes".to_i_with_method # => 20_971_520
    #
    #   20.to_i_with_method   # => 20
    #   20.0.to_i_with_method # => 20
    #   nil.to_i_with_method  # => 0
    #
    def to_i_with_method
      to_x_with_method.to_i
    end

    # Converts to a Float while also evaluating a method invocation
    #
    # This method is similar to #to_f, but does not support extraneous characters.
    #
    #   "20".to_f_with_method           # => 20.0
    #   "20.percent".to_f_with_method   # => 20.0
    #   "20.megabytes".to_f_with_method # => 20_971_520.0
    #
    #   "20.1".to_f_with_method           # => 20.1
    #   "20.1.percent".to_f_with_method   # => 20.1
    #   "20.1.megabytes".to_f_with_method # => 21_076_377.6
    #
    #   20.to_f_with_method   # => 20.0
    #   20.1.to_f_with_method # => 20.1
    #   nil.to_f_with_method  # => 0.0
    #
    def to_f_with_method
      to_x_with_method.to_f
    end

    private def to_x_with_method
      n = delete(',')
      return n unless n =~ NUMBER_WITH_METHOD_REGEX && $2 != "percent"

      n = $1.include?('.') ? $1.to_f : $1.to_i
      n.send($2)
    end

    # Determines if the object contains a number with a method invocation
    #
    #   "20".number_with_method?           # => false
    #   "20.percent".number_with_method?   # => true
    #   "20.0.percent".number_with_method? # => true
    def number_with_method?
      self =~ NUMBER_WITH_METHOD_REGEX
    end
  end

  module NumericAndNilToIWithMethod
    # See String#to_i_with_method
    def to_i_with_method
      to_i
    end

    # See String#to_f_with_method
    def to_f_with_method
      to_f
    end
  end

  module ObjectToIWithMethod
    # See String#number_with_method?
    def number_with_method?
      false
    end
  end
end

String.send(:prepend, MoreCoreExtensions::StringToIWithMethod)
Numeric.send(:prepend, MoreCoreExtensions::NumericAndNilToIWithMethod)
NilClass.send(:prepend, MoreCoreExtensions::NumericAndNilToIWithMethod)
Object.send(:prepend, MoreCoreExtensions::ObjectToIWithMethod)
