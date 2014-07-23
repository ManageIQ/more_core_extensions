require "spec_helper"

describe Array do
  it "#element_counts" do
    expect([].element_counts).to eq({})
    expect([1].element_counts).to eq({1 => 1})
    expect([nil].element_counts).to eq({nil => 1})
    expect([1, 2, 3, 1, 3, 1].element_counts).to eq({1 => 3, 2 => 1, 3 => 2})
  end
end
