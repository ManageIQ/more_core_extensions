require_relative "../../spec_helper"

describe Array do
  it '#duplicates' do
    [1, 2, 3, 4].duplicates.should be_empty
    [1, 2, 3, 4, 2, 4].duplicates.should match_array [2, 4]

    ['1', '2', '3', '4'].duplicates.should be_empty
    ['1', '2', '3', '4', '2', '4'].duplicates.should match_array ['2', '4']
  end
end
