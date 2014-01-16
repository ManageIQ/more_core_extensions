require "spec_helper"

describe Array do
  it "#element_counts" do
    [].element_counts.should == {}
    [1].element_counts.should == {1 => 1}
    [nil].element_counts.should == {nil => 1}
    [1, 2, 3, 1, 3, 1].element_counts.should == {1 => 3, 2 => 1, 3 => 2}
  end
end
