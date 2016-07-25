describe Numeric do
  context "#square" do
    it("Fixnum") { expect(10.square).to   eq(100) }
    it("Float")  { expect(10.2.square).to eq(104.03999999999999) }
  end
end
