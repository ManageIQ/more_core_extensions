require 'active_support/core_ext/digest/uuid'

module Digest
  module UUID
    UUID_REGEX_FORMAT = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/

    # Takes a UUID string of varying formats and cleans it. It will strip invalid characters,
    # such as leading and trailing brackets as well as whitespace. The result is a lowercased,
    # canonical UUID string.
    #
    # If the +guid+ argument is nil or blank, then nil is returned. If the +guid+ is already
    # clean, then no additional cleaning occurs, and it is returned as-is.
    #
    # @param guid [String] A string that should more or less represent a UUID.
    # @return [String] A lowercase v4 UUID string stripped of any extraneous characters.
    #
    def self.clean(guid)
      return nil if guid.nil?
      g = guid.to_s.downcase
      return nil if g.strip.empty?
      return g if g.length == 36 && g =~ UUID_REGEX_FORMAT
      g.delete!('^0-9a-f')
      g.sub!(/^([0-9a-f]{8})([0-9a-f]{4})([0-9a-f]{4})([0-9a-f]{4})([0-9a-f]{12})$/, '\1-\2-\3-\4-\5')
    end
  end
end
