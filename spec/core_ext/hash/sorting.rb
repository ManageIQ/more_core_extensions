describe Hash do
  it "#sort!" do
    h = {:x => 1, :b => 2, :y => 3, :a => 4}
    h_id = h.object_id

    h.sort!

    expect(h.keys).to eq([:a, :b, :x, :y])
    expect(h.object_id).to eq(h_id)
  end

  it "#sort_by!" do
    h = {:x => 1, :b => 2, :y => 3, :a => 4}
    h_id = h.object_id

    h.sort_by! { |k, _v| k }

    expect(h.keys).to eq([:a, :b, :x, :y])
    expect(h.object_id).to eq(h_id)
  end
end
