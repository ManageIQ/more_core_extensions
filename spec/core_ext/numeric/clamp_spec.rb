describe Numeric do
  it "#clamp" do
    expect(8.clamp(nil, nil)).to eq(8)
    expect(8.clamp(3, nil)).to eq(8)
    expect(8.clamp(13, nil)).to eq(13)
    expect(8.clamp(nil, 6)).to eq(6)
    expect(8.clamp(13, 16)).to eq(13)
    expect(20.clamp(13, 16)).to eq(16)

    expect(8.0.clamp(nil, nil)).to eq(8.0)
    expect(8.0.clamp(3.0, nil)).to eq(8.0)
    expect(8.0.clamp(13.0, nil)).to eq(13.0)
    expect(8.0.clamp(nil, 6.0)).to eq(6.0)
    expect(8.0.clamp(13.0, 16.0)).to eq(13.0)
    expect(20.0.clamp(13.0, 16.0)).to eq(16.0)
  end
end
