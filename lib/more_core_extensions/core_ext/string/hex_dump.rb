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
    def hex_dump(options = {})
      HexDumper.new(self, options).dump
    end

    # This class is a private implementation and not part of the public API.
    class HexDumper
      attr_reader :target, :options

      DEFAULT_OPTIONS = {
        :grouping  => 16,
        :newline   => true,
        :start_pos => 0
      }.freeze

      def initialize(target, options)
        @target  = target
        @options = DEFAULT_OPTIONS.merge(options)

        if !!options[:obj] ^ !!options[:meth] # rubocop:disable Style/DoubleNegation
          raise ArgumentError, "obj and meth must both be set, or both not set"
        end
      end

      def dump
        obj, meth, grouping, pos = options.values_at(:obj, :meth, :grouping, :start_pos)

        ret = ""

        target.each_byte.each_slice(grouping) do |bytes|
          row = format_row(pos, bytes)
          ret << row

          if obj
            obj.send(meth, row)
            ret = ""
          end

          pos += grouping
        end

        ret
      end

      def format_row(pos, bytes)
        padding    = "   " * (options[:grouping] - bytes.size)
        byte_chars = bytes.collect { |byte| row_char(byte) }.join
        newline    = "\n" if options[:newline]
        "0x%08x  #{"%02x " * bytes.size}#{padding} " % [pos, *bytes] << "#{byte_chars}#{newline}"
      end

      def row_char(byte)
        byte < 0x20 || (byte >= 0x7F && byte < 0xA0) ? '.' : byte.chr
      end
    end
  end
end

String.send(:include, MoreCoreExtensions::StringHexDump)
