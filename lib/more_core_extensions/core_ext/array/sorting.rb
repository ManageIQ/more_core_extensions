module MoreCoreExtensions
  module StableSorting
    # Sorts an Array of Hashes by specific columns.
    #
    # Rows are sorted by +col_names+, if given, otherwise by the given block.
    #   The +order+ parameter can be given :ascending or :descending and
    #   defaults to :ascending.
    #
    # Note:
    # - Strings are sorted case-insensitively
    # - nil values are sorted last
    # - Boolean values are sorted alphabetically (i.e. false then true)
    #
    #   [
    #     {:col1 => 'b', :col2 => 2},
    #     {:col1 => 'b', :col2 => 1},
    #     {:col1 => 'A', :col2 => 1}
    #   ].tabular_sort([:col1, :col2])
    #
    #   # => [
    #   #   {:col1 => 'A', :col2 => 1},
    #   #   {:col1 => 'b', :col2 => 1},
    #   #   {:col1 => 'b', :col2 => 2}
    #   # ]
    def tabular_sort(col_names = nil, order = nil, &block)
      # stabilizer is needed because of
      # http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/170565
      stabilizer = 0
      nil_rows, sortable =
        partition do |r|
          Array(col_names).any? { |c| r[c].nil? }
        end

      data_array =
        if col_names
          sortable.sort_by do |r|
            stabilizer += 1
            [Array(col_names).map do |col|
              val = r[col]
              val = val.downcase if val.kind_of?(String)
              val = val.to_s     if val.kind_of?(FalseClass) || val.kind_of?(TrueClass)
              val
            end, stabilizer]
          end
        else
          sortable.sort_by(&block)
        end.to_a

      data_array += nil_rows

      data_array.reverse! if order == :descending
      data_array
    end
  end
end

Array.send(:include, MoreCoreExtensions::StableSorting)
