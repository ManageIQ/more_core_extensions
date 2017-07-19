module MoreCoreExtensions
  module SymbolToI
    def to_i
      to_s.to_i
    end
  end
end

Symbol.send(:include, MoreCoreExtensions::SymbolToI) unless Symbol.method_defined?(:to_i)
