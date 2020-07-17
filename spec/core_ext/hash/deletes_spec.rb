describe Hash do
  it "#delete_nils" do
    expect({}.delete_nils).to eq({})
    expect({:a => 1}.delete_nils).to eq({:a => 1})
    expect({:c => nil}.delete_nils).to eq({})
    expect({:a => 1, :b => [], :c => nil}.delete_nils).to eq({:a => 1, :b => []})
  end

  it "#delete_blanks" do
    expect({}.delete_blanks).to eq({})
    expect({:a => 1}.delete_blanks).to eq({:a => 1})
    expect({:c => nil}.delete_blanks).to eq({})
    expect({:a => 1, :b => [], :c => nil}.delete_blanks).to eq({:a => 1})
  end

  it "#deep_delete" do
    expect({}.deep_delete(:c)).to eq({})
    expect({:a => {:b => [1,2], :c => 3}}.deep_delete(:c)).to eq({:a => {:b => [1,2]}})
    expect({:a => {:b => {:c => 1}, :c => 3}}.deep_delete(:c)).to eq({:a => {:b => {}}})
  end
end
