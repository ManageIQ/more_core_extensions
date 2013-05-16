module MoreCoreExtensions::ArrayTableize
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
    case self.first
    when Array; tableize_arrays(options)
    when Hash;  tableize_hashes(options)
    else raise "must be an Array of Arrays or Array of Hashes"
    end
  end

  private

  def tableize_arrays(options)
    options[:header] = true unless options.has_key?(:header)

    widths = []
    justifications = []
    self.each do |row|
      row.each_with_index do |field, field_i|
        widths[field_i] = [widths[field_i].to_i, field.to_s.length].max
        widths[field_i] = [options[:max_width], widths[field_i].to_i].min if options[:max_width]

        justifications[field_i] = field.kind_of?(Numeric) ? "" : "-"
      end
    end

    header_separator = widths.collect { |w| "-" * (w + 2) }.join("+")

    table = []
    self.each_with_index do |row, row_i|
      r = []
      row.each_with_index do |field, field_i|
        r << sprintf("%0#{justifications[field_i]}#{widths[field_i]}s", field.to_s.gsub(/\n|\r/, '').slice(0, widths[field_i]))
      end
      r = " #{r.join(' | ')} ".rstrip

      table << r
      table << header_separator if row_i == 0 && options[:header]
    end
    table.join("\n") << "\n"
  end

  def tableize_hashes(options)
    if options[:columns]
      keys = options[:columns]
    elsif options[:leading_columns] || options[:trailing_columns]
      keys = self.first.keys.sort_by(&:to_s)
      options[:leading_columns].reverse.each { |h| keys.unshift(keys.delete(h)) } if options[:leading_columns]
      options[:trailing_columns].each { |h| keys.push(keys.delete(h)) } if options[:trailing_columns]
    else
      keys = self.first.keys.sort_by(&:to_s)
    end

    options = options.dup
    options[:header] = true
    self.collect { |h| h.values_at(*keys) }.unshift(keys).tableize(options)
  end
end

Array.send(:include, MoreCoreExtensions::ArrayTableize)
