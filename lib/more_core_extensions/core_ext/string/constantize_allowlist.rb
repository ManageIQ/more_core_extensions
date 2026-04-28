require "active_support/core_ext/string/inflections"

module MoreCoreExtensions
  module StringConstantizeAllowlist
    def self.allowed?(target, allowlist)
      allowlist = allowlist.map { |o| o.respond_to?(:name) ? o.name : o }
      allowlist.include?(target)
    end

    def constantize(allowlist: nil)
      if allowlist && !StringConstantizeAllowlist.allowed?(self, allowlist)
        raise NameError, "#{self} not found in allowlist"
      end

      super()
    end

    def safe_constantize(allowlist: nil)
      if allowlist && !StringConstantizeAllowlist.allowed?(self, allowlist)
        return nil
      end

      super()
    end
  end
end

String.prepend MoreCoreExtensions::StringConstantizeAllowlist
