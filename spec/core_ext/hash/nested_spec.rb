shared_examples_for "core_ext/hash/nested will not modify arguments" do |meth|
  it "will not modify arguments" do
    args = (meth == :store_path ? [1] : [])

    key  = ["d", "d1", "d2", "d3"]
    key2 = key.dup
    hash.send(meth, key2, *args)
    expect(key2).to eq(key)

    key  = ["e", "e1", "e2"]
    key2 = key.dup
    hash.send(meth, key2, *args)
    expect(key2).to eq(key)
  end
end

shared_examples_for "core_ext/hash/nested" do
  context '#fetch_path' do
    it "with various values" do
      expect(hash.fetch_path("a")).to eq(1)
      expect(hash.fetch_path("b")).to eq({})
      expect(hash.fetch_path("b", "b1")).to be_nil
      expect(hash.fetch_path("b", "b1", "b2")).to be_nil
      expect(hash.fetch_path("c")).to eq({"c1" => 2})
      expect(hash.fetch_path("c", "c1")).to eq(2)
      expect(hash.fetch_path("c", "c1", "c2")).to be_nil
      expect(hash.fetch_path("d", "d1", "d2", "d3")).to eq(3)
      expect(hash.fetch_path("d", "d1", "d2", "dx")).to be_nil
      expect(hash.fetch_path("d", "d1", "d2", "d3", "d4")).to be_nil
      expect(hash.fetch_path("e")).to eq({})
      expect(hash.fetch_path("e", "e1")).to eq(4)
      expect(hash.fetch_path("e", "e1", "e2")).to be_nil
      expect(hash.fetch_path("f")).to eq({})
      expect(hash.fetch_path("f", "f1")).to eq({})
      expect(hash.fetch_path("f", "f1", "f2")).to be_nil
    end

    it "with a nil value" do
      expect(hash.fetch_path(nil)).to eq({nil => 7})
      expect(hash.fetch_path("d", nil, "d1")).to be_nil
      expect(hash.fetch_path("e", nil)).to eq(4)
      expect(hash.fetch_path("e", nil, "e1")).to be_nil
    end

    it "with array key" do
      expect(hash.fetch_path([["h", "i"]])).to eq(8)
    end

    it "with invalid values" do
      expect { hash.fetch_path }.to raise_error(ArgumentError)
    end

    include_examples "core_ext/hash/nested will not modify arguments", :fetch_path
  end

  context "#store_path" do
    it "on an empty hash" do
      h = described_class.new
      h.store_path("a", 1)
      expect(h).to eq({"a" => 1})

      h = described_class.new
      h.store_path("b", "b1", 2)
      expect(h).to eq({"b" => {"b1" => 2}})
    end

    it "on an existing hash" do
      hash.store_path("b", "b1", 2)
      expect(hash["b"]).to eq({"b1" => 2})
      hash.store_path("c", "c1", 3)
      expect(hash["c"]).to eq({"c1" => 3})
    end

    it "on an existing item that is not a hash" do
      hash.store_path("a", 2)
      expect(hash["a"]).to eq(2)
      hash.store_path("a", "a1", 3)
      expect(hash["a"]).to eq({"a1" => 3})
    end

    it "with an array key" do
      h = described_class.new
      h.store_path([["d", "d1"], ["d2", "d3"]], 3)
      expect(h).to eq({["d", "d1"] => {["d2", "d3"] => 3}})
    end

    it "with a nil value" do
      h = described_class.new
      h.store_path("a", "b", nil)
      expect(h).to eq({"a" => {"b" => nil}})
    end

    it "with an Array value" do
      h = described_class.new
      h.store_path("a", "b", ["c", "d"])
      expect(h).to eq({"a" => {"b" => ["c", "d"]}})
    end

    it "with a Hash value" do
      h = described_class.new
      h.store_path("a", "b", {"c" => "d"})
      expect(h).to eq({"a" => {"b" => {"c" => "d"}}})
    end

    it "with invalid values" do
      expect { described_class.new.store_path }.to raise_error(ArgumentError)
      expect { described_class.new.store_path(1) }.to raise_error(ArgumentError)
    end

    include_examples "core_ext/hash/nested will not modify arguments", :store_path
  end

  context '#has_key_path?' do
    it "with various values" do
      expect(hash.has_key_path?("a")).to be_truthy
      expect(hash.has_key_path?("b")).to be_truthy
      expect(hash.has_key_path?("b", "b1")).to be_falsey
      expect(hash.has_key_path?("b", "b1", "b2")).to be_falsey
      expect(hash.has_key_path?("c")).to be_truthy
      expect(hash.has_key_path?("c", "c1")).to be_truthy
      expect(hash.has_key_path?("c", "c1", "c2")).to be_falsey
      expect(hash.has_key_path?("d", "d1", "d2", "d3")).to be_truthy
      expect(hash.has_key_path?("d", "d1", "d2", "dx")).to be_falsey
      expect(hash.has_key_path?("d", "d1", "d2", "d3", "d4")).to be_falsey
      expect(hash.has_key_path?("e")).to be_truthy
      expect(hash.has_key_path?("e", "e1")).to be_falsey
      expect(hash.has_key_path?("e", "e1", "e2")).to be_falsey
      expect(hash.has_key_path?("f")).to be_truthy
      expect(hash.has_key_path?("f", "f1")).to be_falsey
      expect(hash.has_key_path?("f", "f1", "f2")).to be_falsey
    end

    it "with a nil value" do
      expect(hash.has_key_path?(nil)).to be_truthy
      expect(hash.has_key_path?("d", nil, "d1")).to be_falsey
      expect(hash.has_key_path?("e", nil)).to be_falsey
      expect(hash.has_key_path?("e", nil, "e1")).to be_falsey
    end

    it "with invalid values" do
      expect { hash.has_key_path? }.to raise_error(ArgumentError)
    end

    include_examples "core_ext/hash/nested will not modify arguments", :has_key_path?
  end

  context "#delete_path" do
    it "on a nested hash" do
      hash.delete_path("d", "d1", "d2", "d3")
      expect(hash["d"]).to eq({"d1"=>{"d2"=>{}}})
    end

    it "with an invalid path" do
      hash.delete_path("d", "d1", :d)
      expect(hash["d"]).to eq({"d1"=>{"d2"=>{"d3"=>3}}})
    end

    include_examples "core_ext/hash/nested will not modify arguments", :delete_path
  end

  it "#delete_blank_paths" do
    expect(hash.delete_blank_paths).to eq({"a"=>1, "c"=>{"c1"=>2}, "d"=>{"d1"=>{"d2"=>{"d3"=>3}}}, nil=>{nil=>7}, ["h", "i"]=>8})
  end

  context "#find_path" do
    it "with a real value" do
      expect(hash.find_path(3)).to eq(["d", "d1", "d2", "d3"])
    end

    it "with non-existent value" do
      expect(hash.find_path(42)).to eq([])
    end
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
      "f" => Hash.new { |h, k| h[k] = Hash.new },
      nil => {nil => 7},
      ["h", "i"] => 8
    }
  end

  include_examples "core_ext/hash/nested"
end

begin
  require 'active_support'
  require 'active_support/core_ext/hash'
  describe HashWithIndifferentAccess do
    let(:hash) do
      described_class.new.merge(
        "a"        => 1,
        "b"        => {},
        "c"        => {"c1" => 2},
        "d"        => {"d1" => {"d2" => {"d3" => 3}}},
        "e"        => Hash.new(4),
        "f"        => described_class.new { |h, k| h[k] = described_class.new },
        nil        => {nil => 7},
        ["h", "i"] => 8
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
rescue LoadError
  # ActiveSupport v5.0.0 requires ruby '>=2.2.2', skip these tests on older rubies.
end
