module MoreCoreExtensions
  module IEC60027_2
    # Support converting strings with an IEC60027-2 suffix to an integer
    # http://physics.nist.gov/cuu/Units/binary.html
    # Example: "1 Ki".iec_60027_2_to_i => 1024

    IEC_60027_2_SIZE_SUFFIXES = %w(Ki Mi Gi Ti Pi Ei Zi Yi).freeze
    def iec_60027_2_to_i
      suffix_index = IEC_60027_2_SIZE_SUFFIXES.index(self[-2..-1])
      if suffix_index.nil?
        Integer(self)
      else
        Integer(Float(self[0..-3]) * ((2**10)**(suffix_index + 1)))
      end
    end
  end
end

String.send(:prepend, MoreCoreExtensions::IEC60027_2)
