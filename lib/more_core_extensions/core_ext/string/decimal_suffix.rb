module MoreCoreExtensions
  module DecimalSI
    DECIMAL_SUFFIXES = {"d" => 1e-1, "c" => 1e-2, "m" => 1e-3, "μ" => 1e-6, "n" => 1e-9, "p" => 1e-12, "f" => 1e-15,
                        "a" => 1e-18, "h" => 1e2, "k" => 1e3, "M" => 1e6, "G" => 1e9, "T" => 1e12, "P" => 1e15,
                        "E" => 1e18}.freeze
    def decimal_si_to_f
      multiplier = DECIMAL_SUFFIXES[self[-1]]
      if multiplier
        Float(self[0..-2]) * multiplier
      else
        Float(self)
      end
    end
  end
end

String.send(:prepend, MoreCoreExtensions::DecimalSI)
