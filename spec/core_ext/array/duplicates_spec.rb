describe Array do
  it '#duplicates' do
    expect([1, 2, 3, 4].duplicates).to be_empty
    expect([1, 2, 3, 4, 2, 4].duplicates).to match_array [2, 4]

    expect(['1', '2', '3', '4'].duplicates).to be_empty
    expect(['1', '2', '3', '4', '2', '4'].duplicates).to match_array ['2', '4']
  end
end
