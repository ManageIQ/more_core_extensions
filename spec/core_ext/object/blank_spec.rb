describe "blank" do
  class EmptyTrue
    def empty?
      0
    end
  end

  class EmptyFalse
    def empty?
      nil
    end
  end

  BLANK   = [EmptyTrue.new, nil, false, '', '   ', "  \n\t  \r ", '　', "\u00a0", [], {}].freeze
  PRESENT = [EmptyFalse.new, Object.new, true, 0, 1, 'a', [nil], {nil => 0}].freeze

  describe "#blank?" do
    context "true" do
      BLANK.each { |v| it(v.inspect) { expect(v).to be_blank } }
    end

    context "false" do
      PRESENT.each { |v| it(v.inspect) { expect(v).to_not be_blank } }
    end
  end

  describe "#present?" do
    context "true" do
      PRESENT.each { |v| it(v.inspect) { expect(v).to be_present } }
    end

    context "false" do
      BLANK.each { |v| it(v.inspect) { expect(v).to_not be_present } }
    end
  end

  describe "#presence" do
    context "object" do
      PRESENT.each { |v| it(v.inspect) { expect(v.presence).to eq(v) } }
    end

    context "nil" do
      BLANK.each { |v| it(v.inspect) { expect(v.presence).to be_nil } }
    end
  end
end
