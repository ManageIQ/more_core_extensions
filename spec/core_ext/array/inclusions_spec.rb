require_relative "../../spec_helper"

describe Array do
  it '#include_any?' do
    [1, 2, 3].include_any?(1, 2).should be_true
    [1, 2, 3].include_any?(1, 4).should be_true
    [1, 2, 3].include_any?(4, 5).should be_false

    ['1', '2', '3'].include_any?('1', '2').should be_true
    ['1', '2', '3'].include_any?('1', '4').should be_true
    ['1', '2', '3'].include_any?('4', '5').should be_false
  end

  it '#include_none?' do
    [1, 2, 3].include_none?(1, 2).should be_false
    [1, 2, 3].include_none?(1, 4).should be_false
    [1, 2, 3].include_none?(4, 5).should be_true

    ['1', '2', '3'].include_none?('1', '2').should be_false
    ['1', '2', '3'].include_none?('1', '4').should be_false
    ['1', '2', '3'].include_none?('4', '5').should be_true
  end

  it '#include_all?' do
    [1, 2, 3].include_all?(1, 2).should be_true
    [1, 2, 3].include_all?(1, 4).should be_false
    [1, 2, 3].include_all?(4, 5).should be_false

    ['1', '2', '3'].include_all?('1', '2').should be_true
    ['1', '2', '3'].include_all?('1', '4').should be_false
    ['1', '2', '3'].include_all?('4', '5').should be_false
  end
end
