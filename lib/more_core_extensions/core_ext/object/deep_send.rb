module MoreCoreExtensions
  module ObjectDeepSend
    #
    # Invokes the specified methods continuously, unless encountering a nil value.
    #
    #   10.deep_send("to_s.length")      # => 2
    #   10.deep_send("to_s", "length")   # => 2
    #   10.deep_send(:to_s, :length)     # => 2
    #   10.deep_send(["to_s", "length"]) # => 2
    #   [].deep_send("first.length")     # => nil
    #
    def deep_send(*args)
      args = args.first.dup if args.length == 1 && args.first.kind_of?(Array)
      args = args.shift.to_s.strip.split('.') + args

      arg = args.shift
      raise ArgumentError if arg.nil?

      result = send(arg)
      return nil    if result.nil?
      return result if args.empty?
      result.deep_send(args)
    end
  end
end

Object.send(:include, MoreCoreExtensions::ObjectDeepSend)
