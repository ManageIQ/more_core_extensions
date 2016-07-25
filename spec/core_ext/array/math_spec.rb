describe Array do
  let(:floats)   { [1.1, 2.2, 3.3, 4.4, 5.5] }
  let(:integers) { [1, 2, 3, 4, 5] }

  context "with floats" do
    it("#stddev")   { expect(floats.stddev).to   be_within(0.00001).of(1.73925) }
    it("#mean")     { expect(floats.mean).to     be_within(0.00001).of(3.30000) }
    it("#variance") { expect(floats.variance).to be_within(0.00001).of(3.02500) }
  end

  context "with integers" do
    it("#stddev")   { expect(integers.stddev).to   be_within(0.00001).of(1.58113) }
    it("#mean")     { expect(integers.mean).to     be_within(0.00001).of(3.00000) }
    it("#variance") { expect(integers.variance).to be_within(0.00001).of(2.50000) }
  end
end
