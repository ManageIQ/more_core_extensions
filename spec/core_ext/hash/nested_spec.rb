require_relative "../../spec_helper"

shared_examples_for "core_ext/hash/nested will not modify arguments" do |meth|
  it "will not modify arguments" do
    args = (meth == :store_path ? [1] : [])

    key  = ["d", "d1", "d2", "d3"]
    key2 = key.dup
    hash.send(meth, key2, *args)
    key2.should == key

    key  = ["e", "e1", "e2"]
    key2 = key.dup
    hash.send(meth, key2, *args)
    key2.should == key
  end
end

shared_examples_for "core_ext/hash/nested" do
  context '#fetch_path' do
    it "with various values" do
      hash.fetch_path("a").should == 1
      hash.fetch_path("b").should == {}
      hash.fetch_path("b", "b1").should be_nil
      hash.fetch_path("b", "b1", "b2").should be_nil
      hash.fetch_path("c").should == {"c1" => 2}
      hash.fetch_path("c", "c1").should == 2
      hash.fetch_path("c", "c1", "c2").should be_nil
      hash.fetch_path("d", "d1", "d2", "d3").should == 3
      hash.fetch_path("d", "d1", "d2", "dx").should be_nil
      hash.fetch_path("d", "d1", "d2", "d3", "d4").should be_nil
      hash.fetch_path("e").should == {}
      hash.fetch_path("e", "e1").should == 4
      hash.fetch_path("e", "e1", "e2").should be_nil
      hash.fetch_path("f").should == {}
      hash.fetch_path("f", "f1").should == {}
      hash.fetch_path("f", "f1", "f2").should be_nil
    end

    it "with a nil value" do
      hash.fetch_path(nil).should be_nil
      hash.fetch_path("d", nil, "d1").should be_nil
      hash.fetch_path("e", nil).should == 4
      hash.fetch_path("e", nil, "e1").should be_nil
    end

    it "with invalid values" do
      lambda { hash.fetch_path }.should raise_error(ArgumentError)
    end

    include_examples "core_ext/hash/nested will not modify arguments", :fetch_path
  end

  context "#store_path" do
    it "on an empty hash" do
      h = described_class.new
      h.store_path("a", 1)
      h.should == {"a" => 1}

      h = described_class.new
      h.store_path("b", "b1", 2)
      h.should == {"b" => {"b1" => 2}}
    end

    it "on an existing hash" do
      hash.store_path("b", "b1", 2)
      hash["b"].should == {"b1" => 2}
      hash.store_path("c", "c1", 3)
      hash["c"].should == {"c1" => 3}
    end

    it "on an existing item that is not a hash" do
      hash.store_path("a", 2)
      hash["a"].should == 2
      hash.store_path("a", "a1", 3)
      hash["a"].should == {"a1" => 3}
    end

    it "with an array of keys" do
      h = described_class.new
      h.store_path(["d", "d1", "d2", "d3"], 3)
      h.should == {"d" => {"d1" => {"d2" => {"d3" => 3}}}}
    end

    it "with a nil value" do
      h = described_class.new
      h.store_path("a", "b", nil)
      h.should == {"a" => {"b" => nil}}
    end

    it "with an Array value" do
      h = described_class.new
      h.store_path("a", "b", ["c", "d"])
      h.should == {"a" => {"b" => ["c", "d"]}}
    end

    it "with a Hash value" do
      h = described_class.new
      h.store_path("a", "b", {"c" => "d"})
      h.should == {"a" => {"b" => {"c" => "d"}}}
    end

    it "with invalid values" do
      lambda { described_class.new.store_path }.should raise_error(ArgumentError)
      lambda { described_class.new.store_path(1) }.should raise_error(ArgumentError)
    end

    include_examples "core_ext/hash/nested will not modify arguments", :store_path
  end

  context '#has_key_path?' do
    it "with various values" do
      hash.has_key_path?("a").should be_true
      hash.has_key_path?("b").should be_true
      hash.has_key_path?("b", "b1").should be_false
      hash.has_key_path?("b", "b1", "b2").should be_false
      hash.has_key_path?("c").should be_true
      hash.has_key_path?("c", "c1").should be_true
      hash.has_key_path?("c", "c1", "c2").should be_false
      hash.has_key_path?("d", "d1", "d2", "d3").should be_true
      hash.has_key_path?("d", "d1", "d2", "dx").should be_false
      hash.has_key_path?("d", "d1", "d2", "d3", "d4").should be_false
      hash.has_key_path?("e").should be_true
      hash.has_key_path?("e", "e1").should be_false
      hash.has_key_path?("e", "e1", "e2").should be_false
      hash.has_key_path?("f").should be_true
      hash.has_key_path?("f", "f1").should be_false
      hash.has_key_path?("f", "f1", "f2").should be_false
    end

    it "with a nil value" do
      hash.has_key_path?(nil).should be_false
      hash.has_key_path?("d", nil, "d1").should be_false
      hash.has_key_path?("e", nil).should be_false
      hash.has_key_path?("e", nil, "e1").should be_false
    end

    it "with invalid values" do
      lambda { hash.has_key_path? }.should raise_error(ArgumentError)
    end

    include_examples "core_ext/hash/nested will not modify arguments", :has_key_path?
  end

  context "#delete_path" do
    include_examples "core_ext/hash/nested will not modify arguments", :delete_path
  end
end

describe Hash do
  let(:hash) do
    {
      "a" => 1,
      "b" => {},
      "c" => {"c1" => 2},
      "d" => {"d1" => {"d2" => {"d3" => 3}}},
      "e" => Hash.new(4),
      "f" => Hash.new { |h, k| h[k] = Hash.new }
    }
  end

  include_examples "core_ext/hash/nested"
end

require 'active_support/core_ext/hash'
describe HashWithIndifferentAccess do
  let(:hash) do
    described_class.new.merge(
      "a" => 1,
      "b" => {},
      "c" => {"c1" => 2},
      "d" => {"d1" => {"d2" => {"d3" => 3}}},
      "e" => Hash.new(4),
      "f" => described_class.new { |h, k| h[k] = described_class.new }
    )

    # NOTE: "f" has to be initialized in that way due to a bug in
    #   HashWithIndifferentAccess and assigning a Hash with a default proc.
    #
    # 1.9.3 :001 > h1 = Hash.new
    # 1.9.3 :002 > h1[:a] = Hash.new { |h, k| h[k] = Hash.new }
    # 1.9.3 :003 > h1[:a].class
    #  => Hash
    # 1.9.3 :004 > h1[:a][:b].class
    #  => Hash
    #
    # 1.9.3 :005 > require 'active_support/all'
    # 1.9.3 :006 > h2 = HashWithIndifferentAccess.new
    # 1.9.3 :007 > h2[:a] = Hash.new { |h, k| h[k] = Hash.new }
    # 1.9.3 :008 > h2[:a].class
    #  => ActiveSupport::HashWithIndifferentAccess
    # 1.9.3 :009 > h2[:a][:b].class
    #  => NilClass
  end

  include_examples "core_ext/hash/nested"
end
