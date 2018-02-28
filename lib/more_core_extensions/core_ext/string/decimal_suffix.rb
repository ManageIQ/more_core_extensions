require 'bigdecimal'

module MoreCoreExtensions
  module DecimalSI
    DECIMAL_SUFFIXES = {"d" => "e-1", "c" => "e-2", "m" => "e-3", "μ" => "e-6", "n" => "e-9", "p" => "e-12", "f" => "e-15",
                        "a" => "e-18", "h" => "e2", "k" => "e3", "M" => "e6", "G" => "e9", "T" => "e12", "P" => "e15",
                        "E" => "e18"}.freeze

    def decimal_si_to_f
      Float(decimal_si_to_scientific_notation)
    end

    def decimal_si_to_bigdecimal
      BigDecimal(decimal_si_to_scientific_notation)
    end

    private

    def decimal_si_to_scientific_notation
      multiplier = DECIMAL_SUFFIXES[self[-1]]
      if multiplier
        "#{self[0..-2]}#{multiplier}"
      else
        self
      end
    end
  end
end

String.send(:prepend, MoreCoreExtensions::DecimalSI)
