require 'json'

# Easter Egg.  Not included as part of `more_core_extensions/hash'.
module MoreCoreExtensions
  module Jason
    def self.included(klass)
      klass.send(:alias_method, :to_jason, :to_json)
    end
  end
end

Hash.send(:include, MoreCoreExtensions::Jason)
