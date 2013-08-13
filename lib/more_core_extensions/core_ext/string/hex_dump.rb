module MoreCoreExtensions
  module StringHexDump
    # Dumps the string in a hex editor style format.  Options include:
    #
    # :grouping:: The number of bytes in a line.  Default is 16.
    # :newline:: Whether or not to add a \n after each line.  Default is true.
    # :start_pos:: The number at which byte counts will start.  Default is 0.
    # :obj:: Used in conjunction with _:meth_ to send each line to an object
    #        instead of returning as a string.
    # :meth:: Used in conjunction with _:obj_ to send each line to an object
    #        instead of returning as a string.
    def hex_dump(*opts)
      opts = opts[0] if opts.empty? || (opts.length == 1 && opts[0].kind_of?(Hash))
      raise ArgumentError, "opts must be a Hash" unless opts.nil? || opts.kind_of?(Hash)

      opts = {:grouping => 16, :newline => true, :start_pos => 0}.merge!(opts || {})
      obj, meth, grouping, newline, pos = opts.values_at(:obj, :meth, :grouping, :newline, :start_pos)
      raise ArgumentError, "obj and meth must both be set, or both not set" if (obj.nil? && !meth.nil?) || (!obj.nil? && meth.nil?)

      row_format = "0x%08x  #{"%02x " * grouping} "

      i = 0
      last_i = self.length - 1

      ret = ''
      row_vals = []
      row_chars = ''

      self.each_byte do |c|
        row_vals << c
        row_chars << (c < 0x20 || (c >= 0x7F && c < 0xA0) ? '.' : c.chr)

        if (i + 1) % grouping == 0 || i == last_i
          row_format = "0x%08x  #{"%02x " * row_vals.length}#{"   " * (grouping - row_vals.length)} " if i == last_i

          row_vals.unshift(pos)
          ret << (row_format % row_vals) << row_chars
          ret << "\n" if newline
          if obj
            obj.send(meth, ret)
            ret.replace('')
          end

          pos += grouping
          row_vals.clear
          row_chars = ''
        end

        i += 1
      end

      return ret
    end
  end
end

String.send(:include, MoreCoreExtensions::StringHexDump)
