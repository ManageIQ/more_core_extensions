shared_examples_for "core_ext/array/nested will not modify arguments" do |meth|
  it "will not modify arguments" do
    args = (meth == :store_path ? [1] : [])

    key  = [3, 0, 1, 2]
    key2 = key.dup
    array.send(meth, key2, *args)
    expect(key2).to eq(key)

    key  = [4, 0, 1]
    key2 = key.dup
    array.send(meth, key2, *args)
    expect(key2).to eq(key)
  end
end

shared_examples_for "core_ext/array/nested" do
  context '#fetch_path' do
    it "with various values" do
      expect(array.fetch_path(0)).to eq(1)
      expect(array.fetch_path(1)).to eq([])
      expect(array.fetch_path(1, 0)).to be_nil
      expect(array.fetch_path(1, 0, 1)).to be_nil
      expect(array.fetch_path(2)).to eq([2])
      expect(array.fetch_path(2, 0)).to eq(2)
      expect(array.fetch_path(-4, 0)).to eq(2)
      expect(array.fetch_path(2, 0, 1)).to be_nil
      expect(array.fetch_path(3, 0, 0, 0)).to eq(3)
      expect(array.fetch_path(3, 0, 1, 999)).to be_nil
      expect(array.fetch_path(3, 0, 1, 2, 3)).to be_nil
      expect(array.fetch_path(4)).to eq([nil, nil, nil, nil])
      expect(array.fetch_path(4, 0)).to be_nil
      expect(array.fetch_path(4, 0, 1)).to be_nil
      expect(array.fetch_path(5)).to eq([])
      expect(array.fetch_path(5, 0)).to be_nil
      expect(array.fetch_path(5, 0, 1)).to be_nil
    end

    it "with a nil value should raise ArgumentError" do
      expect { array.fetch_path(nil) }.to raise_error(ArgumentError)
      expect { array.fetch_path(3, nil, 0) }.to raise_error(ArgumentError)
    end

    it "with invalid values" do
      expect { array.fetch_path }.to raise_error(ArgumentError)
    end

    include_examples "core_ext/array/nested will not modify arguments", :fetch_path
  end

  context "#store_path" do
    it "on an empty array" do
      a = described_class.new
      a.store_path(0, 1)
      expect(a).to eq([1])

      a = described_class.new
      a.store_path(1, 0, 2)
      expect(a).to eq([nil, [2]])
    end

    it "on an existing array" do
      array.store_path(1, 0, 2)
      expect(array[1]).to eq([2])
      array.store_path(2, 0, 3)
      expect(array[2]).to eq([3])
      array.store_path(-4, 0, 3)
      expect(array[2]).to eq([3])
    end

    it "on an existing item that is not a array" do
      array.store_path(0, 2)
      expect(array[0]).to eq(2)
      array.store_path(0, 0, 3)
      expect(array[0]).to eq([3])
    end

    it "with an array of args" do
      a = described_class.new
      a.store_path([3, 0, 1, 2], 3)
      expect(a).to eq([nil, nil, nil, [[nil, [nil, nil, 3]]]])
    end

    it "with a nil value" do
      a = described_class.new
      a.store_path(0, 1, nil)
      expect(a).to eq([[nil, nil]])
    end

    it "with an Array value" do
      a = described_class.new
      a.store_path(0, 1, [2, 3])
      expect(a).to eq([[nil, [2, 3]]])
    end

    it "with a Hash value" do
      a = described_class.new
      a.store_path(0, 1, {2 => 3})
      expect(a).to eq([[nil, {2 => 3}]])
    end

    it "with invalid values" do
      expect { described_class.new.store_path }.to raise_error(ArgumentError)
      expect { described_class.new.store_path(1) }.to raise_error(ArgumentError)
    end

    include_examples "core_ext/array/nested will not modify arguments", :store_path
  end

  context '#has_key_path?' do
    it "with various values" do
      expect(array.has_key_path?(0)).to be_truthy
      expect(array.has_key_path?(1)).to be_truthy
      expect(array.has_key_path?(1, 0)).to be_falsey
      expect(array.has_key_path?(1, 0, 1)).to be_falsey
      expect(array.has_key_path?(2)).to be_truthy
      expect(array.has_key_path?(2, 0)).to be_truthy
      expect(array.has_key_path?(2, 0, 1)).to be_falsey
      expect(array.has_key_path?(3, 0, 1, 2)).to be_falsey
      expect(array.has_key_path?(3, 0, 1, 999)).to be_falsey
      expect(array.has_key_path?(3, 0, 1, 2, 3)).to be_falsey
      expect(array.has_key_path?(4)).to be_truthy
      expect(array.has_key_path?(4, 0)).to be_truthy
      expect(array.has_key_path?(4, 0, 1)).to be_falsey
      expect(array.has_key_path?(5)).to be_truthy
      expect(array.has_key_path?(5, 0)).to be_falsey
      expect(array.has_key_path?(5, 0, 1)).to be_falsey
    end

    it "with a nil value" do
      expect { array.fetch_path(nil) }.to raise_error(ArgumentError)
      expect { array.fetch_path(3, nil, 0) }.to raise_error(ArgumentError)
    end

    it "with invalid values" do
      expect { array.has_key_path? }.to raise_error(ArgumentError)
    end

    include_examples "core_ext/array/nested will not modify arguments", :has_key_path?
  end

  context "#delete_path" do
    it "on a nested array" do
      array.delete_path(3, 0, 0, 0)
      expect(array[3]).to eq([[[]]])
    end

    it "with an invalid path" do
      array.delete_path(3, 0, 5)
      expect(array[3]).to eq([[[3]]])
    end

    include_examples "core_ext/array/nested will not modify arguments", :delete_path
  end

  it "#delete_blank_paths" do
    expect(array.delete_blank_paths).to eq([1, [2], [[[3]]]])
  end

  context "#find_path" do
    it "with a real value" do
      expect(array.find_path(3)).to eq([3, 0, 0, 0])
    end

    it "with non-existent value" do
      expect(array.find_path(42)).to eq([])
    end
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
