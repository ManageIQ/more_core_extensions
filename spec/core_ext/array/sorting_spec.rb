describe Array do
  let(:unsorted_enumerable) do
    [
        {:id => :a, :int => 3, :string => "a", :bool => true},
        {:id => :b, :int => 1, :string => "b", :bool => true},
        {:id => :c, :int => 2, :string => "B", :bool => false},
        {:id => :d, :int => 0, :string => "b", :bool => false},
        {:id => :e, :int => 1, :string => "D", :bool => false},
        {:id => :f, :int => 0, :string => "d", :bool => nil},
        {:id => :g, :int => 1, :string => "E", :bool => true},
        {:id => :h, :int => 2, :string => "e", :bool => true},
    ]
  end

  let(:int_sorted_array) do
    [
        {:id => :d, :int => 0, :string => "b", :bool => false},
        {:id => :f, :int => 0, :string => "d", :bool => nil},
        {:id => :b, :int => 1, :string => "b", :bool => true},
        {:id => :e, :int => 1, :string => "D", :bool => false},
        {:id => :g, :int => 1, :string => "E", :bool => true},
        {:id => :c, :int => 2, :string => "B", :bool => false},
        {:id => :h, :int => 2, :string => "e", :bool => true},
        {:id => :a, :int => 3, :string => "a", :bool => true},
    ]
  end

  let(:string_sorted_array) do
    [
        {:id => :a, :int => 3, :string => "a", :bool => true},
        {:id => :b, :int => 1, :string => "b", :bool => true},
        {:id => :c, :int => 2, :string => "B", :bool => false},
        {:id => :d, :int => 0, :string => "b", :bool => false},
        {:id => :e, :int => 1, :string => "D", :bool => false},
        {:id => :f, :int => 0, :string => "d", :bool => nil},
        {:id => :g, :int => 1, :string => "E", :bool => true},
        {:id => :h, :int => 2, :string => "e", :bool => true},
    ]
  end

  let(:bool_sorted_array) do
    [
        {:id => :c, :int => 2, :string => "B", :bool => false},
        {:id => :d, :int => 0, :string => "b", :bool => false},
        {:id => :e, :int => 1, :string => "D", :bool => false},
        {:id => :a, :int => 3, :string => "a", :bool => true},
        {:id => :b, :int => 1, :string => "b", :bool => true},
        {:id => :g, :int => 1, :string => "E", :bool => true},
        {:id => :h, :int => 2, :string => "e", :bool => true},
        {:id => :f, :int => 0, :string => "d", :bool => nil},
    ]
  end

  it "sorts stable when order is ascending" do
    expect(unsorted_enumerable.stable_sort_by([:int])).to eq(int_sorted_array)
    expect(unsorted_enumerable.stable_sort_by([:string])).to eq(string_sorted_array)
    expect(unsorted_enumerable.stable_sort_by([:bool])).to eq(bool_sorted_array)
  end

  it "sorts stable when order is descending" do
    expect(unsorted_enumerable.stable_sort_by([:int], :descending)).to eq(int_sorted_array.reverse)
    expect(unsorted_enumerable.stable_sort_by([:string], :descending)).to eq(string_sorted_array.reverse)
    expect(unsorted_enumerable.stable_sort_by([:bool], :descending)).to eq(bool_sorted_array.reverse)
  end
end
