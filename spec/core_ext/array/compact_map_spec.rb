describe Array do
  it "#compact_map" do
    expect([].compact_map).to be_kind_of(Enumerable)
    expect([].compact_map { |i| i * 2 if i.odd? }).to eq([])
    expect([1, 2, 3, 4, 5].compact_map { |i| i * 2 if i.odd? }).to eq([2, 6, 10])
  end
end
