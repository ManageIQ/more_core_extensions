describe Class do
  context ".descendant_get" do
    let!(:base_class) do
      Class.new do
        def self.name
          "Base"
        end
      end
    end
    let!(:subclass_class) do
      Class.new(base_class) do
        def self.name
          "SubClass"
        end
      end
    end

    it "returns self if specified" do
      expect(subclass_class.descendant_get("SubClass")).to eq(subclass_class)
    end

    it "returns the correct descendant" do
      expect(base_class.descendant_get("SubClass")).to eq(subclass_class)
    end

    it "raises an error if no descendant is found" do
      expect { base_class.descendant_get('Foo') }.to raise_error(ArgumentError, "Foo is not a descendant of Base")
    end
  end
end
