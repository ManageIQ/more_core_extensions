require_relative "../../spec_helper"

describe Hash do
  it "#delete_nils" do
    {}.delete_nils.should == {}
    {:a => 1}.delete_nils.should == {:a => 1}
    {:c => nil}.delete_nils.should == {}
    {:a => 1, :b => [], :c => nil}.delete_nils.should == {:a => 1, :b => []}
  end

  it "#delete_blanks" do
    {}.delete_blanks.should == {}
    {:a => 1}.delete_blanks.should == {:a => 1}
    {:c => nil}.delete_blanks.should == {}
    {:a => 1, :b => [], :c => nil}.delete_blanks.should == {:a => 1}
  end

  it "#purge_blanks" do
    {}.purge_blanks.should == {}
    {:a => 1}.purge_blanks.should == {:a => 1}
    {:c => nil}.purge_blanks.should == {}
    {:a => 1, :b => [], :c => nil}.purge_blanks.should == {:a => 1}
    {:a => {:b => []}, :c => 1}.purge_blanks.should == {:c => 1}
  end
end
