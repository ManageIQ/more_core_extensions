require_relative "../../spec_helper"

shared_examples_for "core_ext/array/nested will not modify arguments" do |meth|
  it "will not modify arguments" do
    args = (meth == :store_path ? [1] : [])

    key  = [3, 0, 1, 2]
    key2 = key.dup
    array.send(meth, key2, *args)
    key2.should == key

    key  = [4, 0, 1]
    key2 = key.dup
    array.send(meth, key2, *args)
    key2.should == key
  end
end

shared_examples_for "core_ext/array/nested" do
  context '#fetch_path' do
    it "with various values" do
      array.fetch_path(0).should == 1
      array.fetch_path(1).should == []
      array.fetch_path(1, 0).should be_nil
      array.fetch_path(1, 0, 1).should be_nil
      array.fetch_path(2).should == [2]
      array.fetch_path(2, 0).should == 2
      array.fetch_path(-4, 0).should == 2
      array.fetch_path(2, 0, 1).should be_nil
      array.fetch_path(3, 0, 0, 0).should == 3
      array.fetch_path(3, 0, 1, 999).should be_nil
      array.fetch_path(3, 0, 1, 2, 3).should be_nil
      array.fetch_path(4).should == [nil, nil, nil, nil]
      array.fetch_path(4, 0).should be_nil
      array.fetch_path(4, 0, 1).should be_nil
      array.fetch_path(5).should == []
      array.fetch_path(5, 0).should be_nil
      array.fetch_path(5, 0, 1).should be_nil
    end

    it "with a nil value should raise ArgumentError" do
      lambda { array.fetch_path(nil) }.should raise_error(ArgumentError)
      lambda { array.fetch_path(3, nil, 0) }.should raise_error(ArgumentError)
    end

    it "with invalid values" do
      lambda { array.fetch_path }.should raise_error(ArgumentError)
    end

    include_examples "core_ext/array/nested will not modify arguments", :fetch_path
  end

  context "#store_path" do
    it "on an empty array" do
      a = described_class.new
      a.store_path(0, 1)
      a.should == [1]

      a = described_class.new
      a.store_path(1, 0, 2)
      a.should == [nil, [2]]
    end

    it "on an existing array" do
      array.store_path(1, 0, 2)
      array[1].should == [2]
      array.store_path(2, 0, 3)
      array[2].should == [3]
      array.store_path(-4, 0, 3)
      array[2].should == [3]
    end

    it "on an existing item that is not a array" do
      array.store_path(0, 2)
      array[0].should == 2
      array.store_path(0, 0, 3)
      array[0].should == [3]
    end

    it "with an array of args" do
      a = described_class.new
      a.store_path([3, 0, 1, 2], 3)
      a.should == [nil, nil, nil, [[nil, [nil, nil, 3]]]]
    end

    it "with a nil value" do
      a = described_class.new
      a.store_path(0, 1, nil)
      a.should == [[nil, nil]]
    end

    it "with an Array value" do
      a = described_class.new
      a.store_path(0, 1, [2, 3])
      a.should == [[nil, [2, 3]]]
    end

    it "with a Hash value" do
      a = described_class.new
      a.store_path(0, 1, {2 => 3})
      a.should == [[nil, {2 => 3}]]
    end

    it "with invalid values" do
      lambda { described_class.new.store_path }.should raise_error(ArgumentError)
      lambda { described_class.new.store_path(1) }.should raise_error(ArgumentError)
    end

    include_examples "core_ext/array/nested will not modify arguments", :store_path
  end

  context '#has_key_path?' do
    it "with various values" do
      array.has_key_path?(0).should be_true
      array.has_key_path?(1).should be_true
      array.has_key_path?(1, 0).should be_false
      array.has_key_path?(1, 0, 1).should be_false
      array.has_key_path?(2).should be_true
      array.has_key_path?(2, 0).should be_true
      array.has_key_path?(2, 0, 1).should be_false
      array.has_key_path?(3, 0, 1, 2).should be_false
      array.has_key_path?(3, 0, 1, 999).should be_false
      array.has_key_path?(3, 0, 1, 2, 3).should be_false
      array.has_key_path?(4).should be_true
      array.has_key_path?(4, 0).should be_true
      array.has_key_path?(4, 0, 1).should be_false
      array.has_key_path?(5).should be_true
      array.has_key_path?(5, 0).should be_false
      array.has_key_path?(5, 0, 1).should be_false
    end

    it "with a nil value" do
      lambda { array.fetch_path(nil) }.should raise_error(ArgumentError)
      lambda { array.fetch_path(3, nil, 0) }.should raise_error(ArgumentError)
    end

    it "with invalid values" do
      lambda { array.has_key_path? }.should raise_error(ArgumentError)
    end

    include_examples "core_ext/array/nested will not modify arguments", :has_key_path?
  end
end

describe Array do
  let(:array) do
    [ 1,
      [],
      [2],
      [[[3]]],
      Array.new(4),
      described_class.new { |i| i = described_class.new }
    ]
  end

  include_examples "core_ext/array/nested"
end