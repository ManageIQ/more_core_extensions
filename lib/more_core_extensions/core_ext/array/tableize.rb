module MoreCoreExtensions
  module ArrayTableize
    # Create a string representation of _self_ in a tabular format if self is an
    # Array of Arrays or an Array of Hashes.
    #
    # If an Array of Hashes is passed, the headers are assumed from the keys in
    # the first element of the Array, and the header option is ignored.  Also,
    # the headers are sorted, unless overridden with options.
    #
    # General options:
    # ::max_width: Maximum column width, in order to limit wide columns.
    #
    # Options with Array of Arrays:
    # ::header: Whether or not the first row of data is a header row. Default is
    #           true.
    #
    # Options with Array of Hashes:
    # ::columns: An Array of keys that define the order of all columns.
    # ::leading_columns: An Array of keys that should be moved to the left side
    #                    of the table.  This option is ignored if columns option
    #                    is passed.
    # ::trailing_columns: An Array of keys that should be moved to the right side
    #                     of the table.  This option is ignored if columns option
    #                     is passed.
    #
    #   [["Col1", "Col2"], ["Val1", "Val2"], ["Value3", "Value4"]].tableize #=>
    #
    #    Col1   | Col2
    #   --------+--------
    #    Val1   | Val2
    #    Value3 | Value4
    #
    def tableize(options = {})
      Tableizer.new(self, options).tableize
    end

    # This class is a private implementation and not part of the public API.
    class Tableizer
      attr_accessor :target, :options

      def initialize(target, options)
        @target = target
        @options = options
      end

      def tableize
        case target.first
        when Array then tableize_arrays
        when Hash  then tableize_hashes
        else raise "must be an Array of Arrays or Array of Hashes"
        end
      end

      private

      def tableize_hashes
        # Convert the target to an Array of Arrays
        keys = options[:columns] || columns_from_hash_keys
        self.target = target.collect { |h| h.values_at(*keys) }.unshift(keys)
        options[:header] = true

        tableize_arrays
      end

      def columns_from_hash_keys
        target.first.keys.sort_by(&:to_s).tap do |keys|
          apply_leading_columns!(keys)
          apply_trailing_columns!(keys)
        end
      end

      def apply_leading_columns!(keys)
        return unless options[:leading_columns]
        options[:leading_columns].reverse_each { |h| keys.unshift(keys.delete(h)) }
      end

      def apply_trailing_columns!(keys)
        return unless options[:trailing_columns]
        options[:trailing_columns].each { |h| keys.push(keys.delete(h)) }
      end

      def tableize_arrays
        options[:header] = true unless options.key?(:header)

        widths, justifications = widths_and_justifications
        table = target.collect { |row| format_row(row, widths, justifications) }
        format_table(table, widths)
      end

      def widths_and_justifications
        widths = []
        justifications = []

        target.each do |row|
          row.each.with_index do |field, field_i|
            apply_width!(widths, field, field_i)
            apply_justification!(justifications, field, field_i)
          end
        end

        return widths, justifications
      end

      def apply_width!(widths, field, field_i)
        widths[field_i] = [widths[field_i].to_i, field.to_s.length].max
        widths[field_i] = [options[:max_width], widths[field_i].to_i].min if options[:max_width]
      end

      def apply_justification!(justifications, field, field_i)
        justifications[field_i] = field.kind_of?(Numeric) ? "" : "-"
      end

      def format_row(row, widths, justifications)
        formatted_fields = row.collect.with_index do |field, field_i|
          format_field(field, widths[field_i], justifications[field_i])
        end
        " #{formatted_fields.join(' | ')} ".rstrip
      end

      def format_field(field, width, justification)
        field = field.to_s.gsub(/\n|\r/, '').slice(0, width)
        "%0#{justification}#{width}s" % field
      end

      def format_table(table, widths)
        if options[:header] && table.size > 1
          header_separator = widths.collect { |w| "-" * (w + 2) }.join("+")
          table.insert(1, header_separator)
        end
        table.join("\n") << "\n"
      end
    end
  end
end

Array.send(:include, MoreCoreExtensions::ArrayTableize)
