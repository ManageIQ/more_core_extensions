module MoreCoreExtensions
  module StableSorting
    def stable_sort_by(col_names = nil, order = nil, &block)
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
