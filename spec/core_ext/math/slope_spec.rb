describe Math do
  it ".slope_y_intercept" do
    expect(described_class.slope_y_intercept(1, 1, 0)).to eq(1)
    expect(described_class.slope_y_intercept(2, 1, 0)).to eq(2)
    expect(described_class.slope_y_intercept(10, 1, 0)).to eq(10)
    expect(described_class.slope_y_intercept(10, 2, 0)).to eq(20)
  end

  it ".slope_x_intercept" do
    expect(described_class.slope_x_intercept(1, 1, 0)).to eq(1)
    expect(described_class.slope_x_intercept(2, 1, 0)).to eq(2)
    expect(described_class.slope_x_intercept(10, 1, 0)).to eq(10)
    expect(described_class.slope_x_intercept(10, 2, 0)).to eq(5)
  end

  it ".linear_regression" do
    expect(described_class.linear_regression([1.0, 1.0], [2.0, 2.0])).to eq([1.0, 0.0, 1.0])
    expect(described_class.linear_regression([1.0, 1.0], [1.5, 2.0])).to eq([2.0, -1.0, 1.0])
  end
end
