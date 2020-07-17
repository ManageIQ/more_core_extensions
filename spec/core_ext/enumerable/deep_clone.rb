describe Enumerable do
  before do
    @nested_hash  = {'outer' => {:name => 'test', :value => [1, 2], :token => 1}}
    @nested_array = [{'outer' => {:name => 'test', :value => [1, 2], :token => 1}}]
  end

  context "Hash#deep_clone" do
    it "deep clones a hash as expected" do
      expect(@nested_hash.deep_clone).to eq(@nested_hash)
    end

    it "doesn't modify the clone if the original is modified" do
      clone = @nested_hash.deep_clone
      @nested_hash['outer'][:name] << 'stuff'

      expect(@nested_hash['outer'][:name]).to eq('teststuff')
      expect(clone['outer'][:name]).to eq('test')
    end
  end

  context "Array#deep_clone" do
    it "deep clones an array as expected" do
      expect(@nested_array.deep_clone).to eq(@nested_array)
    end

    it "doesn't modify the clone if the original is modified" do
      clone = @nested_array.deep_clone
      @nested_array[0]['outer'][:name] << 'stuff'

      expect(@nested_array[0]['outer'][:name]).to eq('teststuff')
      expect(clone[0]['outer'][:name]).to eq('test')
    end
  end
end
