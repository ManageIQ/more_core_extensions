require_relative "../../spec_helper"

describe Array do
  it "#delete_nils" do
    [].delete_nils.should == []
    [1].delete_nils.should == [1]
    [nil].delete_nils.should == []
    [1, [], nil].delete_nils.should == [1, []]
  end

  it "#delete_blanks" do
    [].delete_blanks.should == []
    [1].delete_blanks.should == [1]
    [nil].delete_blanks.should == []
    [1, [], nil].delete_blanks.should == [1]
  end
end