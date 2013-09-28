require_relative '../shared/nested'

module MoreCoreExtensions
  module ArrayNested
    include MoreCoreExtensions::Shared::Nested
    extend  MoreCoreExtensions::Shared::Nested
  end
end

Array.send(:include, MoreCoreExtensions::ArrayNested)