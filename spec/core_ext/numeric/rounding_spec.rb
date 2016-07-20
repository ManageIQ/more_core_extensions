describe Numeric do
  context "#round_up" do
    it("Fixnum")  { expect(1.round_up).to   eq(1) }
    it("Float")   { expect(1.1.round_up).to eq(2.0) }
    context "with a 'nearest' param" do
      it("Fixnum")  { expect(1.round_up(10)).to    eq(10) }
      it("Float")   { expect(1.1.round_up(0.5)).to eq(1.5) }
    end
  end

  context "#round_down" do
    it("Fixnum")  { expect(1.round_down).to   eq(1) }
    it("Float")   { expect(1.1.round_down).to eq(1.0) }
    context "with a 'nearest' param" do
      it("Fixnum")  { expect(11.round_down(10)).to   eq(10) }
      it("Float")   { expect(1.6.round_down(0.5)).to eq(1.5) }
    end
  end
end
