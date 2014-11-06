require_relative "../../spec_helper"

describe Array do
  it "#delete_nils" do
    expect([].delete_nils).to eq([])
    expect([1].delete_nils).to eq([1])
    expect([nil].delete_nils).to eq([])
    expect([1, [], nil].delete_nils).to eq([1, []])
  end

  it "#delete_blanks" do
    expect([].delete_blanks).to eq([])
    expect([1].delete_blanks).to eq([1])
    expect([nil].delete_blanks).to eq([])
    expect([1, [], nil].delete_blanks).to eq([1])
  end
end