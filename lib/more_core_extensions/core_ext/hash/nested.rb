require_relative '../shared/nested'

module MoreCoreExtensions
  module HashNested
    include MoreCoreExtensions::Shared::Nested
    extend  MoreCoreExtensions::Shared::Nested
  end
end

Hash.send(:include, MoreCoreExtensions::HashNested)
