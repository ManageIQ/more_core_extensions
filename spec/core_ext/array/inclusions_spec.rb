require_relative "../../spec_helper"

describe Array do
  it '#include_any?' do
    expect([1, 2, 3].include_any?(1, 2)).to be_truthy
    expect([1, 2, 3].include_any?(1, 4)).to be_truthy
    expect([1, 2, 3].include_any?(4, 5)).to be_falsey

    expect(['1', '2', '3'].include_any?('1', '2')).to be_truthy
    expect(['1', '2', '3'].include_any?('1', '4')).to be_truthy
    expect(['1', '2', '3'].include_any?('4', '5')).to be_falsey
  end

  it '#include_none?' do
    expect([1, 2, 3].include_none?(1, 2)).to be_falsey
    expect([1, 2, 3].include_none?(1, 4)).to be_falsey
    expect([1, 2, 3].include_none?(4, 5)).to be_truthy

    expect(['1', '2', '3'].include_none?('1', '2')).to be_falsey
    expect(['1', '2', '3'].include_none?('1', '4')).to be_falsey
    expect(['1', '2', '3'].include_none?('4', '5')).to be_truthy
  end

  it '#include_all?' do
    expect([1, 2, 3].include_all?(1, 2)).to be_truthy
    expect([1, 2, 3].include_all?(1, 4)).to be_falsey
    expect([1, 2, 3].include_all?(4, 5)).to be_falsey

    expect(['1', '2', '3'].include_all?('1', '2')).to be_truthy
    expect(['1', '2', '3'].include_all?('1', '4')).to be_falsey
    expect(['1', '2', '3'].include_all?('4', '5')).to be_falsey
  end

  it "#includes_index?" do
    expect([1, 2, 3].includes_index?(-4)).to be_falsey
    expect([1, 2, 3].includes_index?(-3)).to be_truthy
    expect([1, 2, 3].includes_index?(1)).to be_truthy
    expect([1, 2, 3].includes_index?(2)).to be_truthy
    expect([1, 2, 3].includes_index?(3)).to be_falsey
  end
end
