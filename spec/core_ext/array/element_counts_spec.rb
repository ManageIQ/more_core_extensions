describe Array do
  describe "#element_counts" do
    it "without a block" do
      expect([].element_counts).to eq({})
      expect([1].element_counts).to eq({1 => 1})
      expect([nil].element_counts).to eq({nil => 1})
      expect([1, 2, 3, 1, 3, 1].element_counts).to eq({1 => 3, 2 => 1, 3 => 2})
    end

    it "with a block" do
      expect([].element_counts(&:size)).to eq({})
      expect(%w(a).element_counts(&:size)).to eq({1 => 1})
      expect(%w(a aa aaa a aaa a).element_counts(&:size)).to eq({1 => 3, 2 => 1, 3 => 2})
    end
  end
end
