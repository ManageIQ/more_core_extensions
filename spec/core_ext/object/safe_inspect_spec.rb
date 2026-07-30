require "more_core_extensions/core_ext/object/safe_inspect"

describe  do
  describe "#inspect" do
    let(:instance) do
      Object.new.tap do |o|
        o.singleton_class.include(MoreCoreExtensions::ObjectSafeInspect)
        o.instance_eval do
          @a = "aaa"
          @b = "bbb"
        end
      end
    end

    it "default" do
      expect(instance.inspect).to match(/\A#<Object:0x\h+ @a="aaa", @b="bbb">\z/)
    end

    it "hiding instance variables" do
      def instance.instance_variables_to_inspect
        [:@b]
      end
      expect(instance.inspect).to match(/\A#<Object:0x\h+ @b="bbb">\z/)
    end

    it "hiding instance variables with pretty print" do
      def instance.pretty_print_instance_variables
        [:@b]
      end
      expect(instance.inspect).to match(/\A#<Object:0x\h+ @b="bbb">\z/)
    end
  end
end
