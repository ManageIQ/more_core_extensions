describe MoreCoreExtensions::Shared::Nested do
  context "with an array nested with some hashes" do
    let(:array) {
      [
        {},
        { :a => nil, :b => "b" },
        { 1 => 1, 2 => { 2 => 2 }},
        { "a" => [{ "a1" => 1 }, { "a2" => 2 }] }
      ]
    }

    context "#fetch_path" do
      it "on a empty existing nested hash" do
        expect(array.fetch_path(0, "a")).to be_nil
        expect(array.fetch_path(0, 1)).to   be_nil
      end

      it "on a existing nested hash" do
        expect(array.fetch_path(1, :a)).to be_nil
        expect(array.fetch_path(1, :b)).to eq("b")
        expect(array.fetch_path(1, :c)).to be_nil
      end

      it "on a deeply nested hash" do
        expect(array.fetch_path(2, 1)).to eq(1)
        expect(array.fetch_path(2, 2)).to eq(2 => 2)
        expect(array.fetch_path(2, 2, 2)).to eq(2)
        expect(array.fetch_path(2, 3)).to be_nil
        expect(array.fetch_path(2, 2, 3)).to be_nil
      end

      it "on a deeply nested hash/array" do
        expect(array.fetch_path(3, "a", 0, "a1")).to eq(1)
        expect(array.fetch_path(3, "a", 1, "a2")).to eq(2)
        expect(array.fetch_path(3, "a", 2, "a3")).to be_nil
      end
    end

    context "#store_path" do
      it "on a empty existing nested hash" do
        array.store_path(0, "a", 1)
        expect(array[0]).to eq("a" => 1)
      end

      it "on a empty existing nested hash with deep nested path" do
        array.store_path(0, "b", "b1", 2)
        expect(array[0]).to eq("b" => {"b1" => 2})
      end

      it "on a existing nested hash" do
        array.store_path(1, :a, "a")
        expect(array[1]).to eq(:a => "a", :b => "b")
        array.store_path(1, "a", "a")
        expect(array[1]).to eq(:a => "a", :b => "b", "a" => "a")
      end

      it "on a deeply nested hash" do
        array.store_path(2, 1, "one")
        expect(array[2]).to eq(1 => "one", 2 => {2 => 2})
        array.store_path(2, 2, 2, "two")
        expect(array[2]).to eq(1 => "one", 2 => {2 => "two"})
        array.store_path(2, 2, 3, 3)
        expect(array[2]).to eq(1 => "one", 2 => {2 => "two", 3 => 3})
      end

      it "on a deeply nested hash/array" do
        array.store_path(3, "a", 0, "a1", "one")
        expect(array[3]).to eq("a" => [{"a1" => "one"}, {"a2" => 2}])
        array.store_path(3, "a", 1, "two")
        expect(array[3]).to eq("a" => [{"a1" => "one"}, "two"])
        array.store_path(3, 3, "three")
        expect(array[3]).to eq("a" => [{"a1" => "one"}, "two"], 3 => "three")
        array.store_path(3, "a", 0, :nil, nil)
        expect(array[3]).to eq("a" => [{"a1" => "one", :nil => nil}, "two"], 3 => "three")
        array.store_path(3, "a", 3, nil)
        expect(array[3]).to eq("a" => [{"a1" => "one", :nil => nil}, "two", nil, nil], 3 => "three")
      end
    end
  end

  context "with an hash nested with some arrays" do
    let(:hash) {
      {
        "a" => [],
        "b" => [1, 2, 3],
        "c" => [1, [2, 3]],
        "d" => [1, { "2" => 2, "3" => [1, 2, 3] }]
      }
    }

    context "#fetch_path" do
      it "on a empty existing nested array" do
        expect(hash.fetch_path("a", 0)).to    be_nil
        expect(hash.fetch_path("a", 0, 0)).to be_nil
      end

      it "on a existing nested array" do
        expect(hash.fetch_path("b", 0)).to    eq(1)
        expect(hash.fetch_path("b", 2)).to    eq(3)
        expect(hash.fetch_path("b", 3)).to    be_nil
        expect(hash.fetch_path("b", 0, 0)).to be_nil
      end

      it "on a deeply nested array" do
        expect(hash.fetch_path("c", 1, 0)).to eq(2)
        expect(hash.fetch_path("c", 1, 1)).to eq(3)
      end

      it "on a deeply nested hash/array" do
        expect(hash.fetch_path("d", 1, "2")).to    eq(2)
        expect(hash.fetch_path("d", 1, "3", 2)).to eq(3)
        expect(hash.fetch_path("d", 1, "3", 4)).to be_nil
      end
    end

    context "#store_path" do
      it "on a empty existing nested array" do
        hash.store_path("a", 0, 1)
        expect(hash["a"]).to eq([1])
        hash.store_path("a", 1, 0, 2)
        expect(hash["a"]).to eq([1, [2]])
      end

      it "on a existing nested array" do
        hash.store_path("b", 0, 0)
        expect(hash["b"]).to eq([0, 2, 3])
        hash.store_path("b", 5, 0)
        expect(hash["b"]).to eq([0, 2, 3, nil, nil, 0])
      end

      it "on a deeply nested array" do
        hash.store_path("c", 1, 2, 4)
        expect(hash["c"]).to eq([1, [2, 3, 4]])
        hash.store_path("c", 1, 3, 4, 5)
        expect(hash["c"]).to eq([1, [2, 3, 4, [nil, nil, nil, nil, 5]]])
      end

      it "on a deeply nested array/hash" do
        hash.store_path("d", 1, "3", 4, 5)
        expect(hash["d"]).to eq([1, { "2" => 2, "3" => [1, 2, 3, nil, 5] }])
        hash.store_path("d", 1, "3", 3, 3 => "3")
        expect(hash["d"]).to eq([1, { "2" => 2, "3" => [1, 2, 3, { 3 => "3" }, 5] }])
        hash.store_path("d", 1, "3", 3, 2, 1)
        expect(hash["d"]).to eq([1, { "2" => 2, "3" => [1, 2, 3, { 3 => "3", 2 => 1 }, 5] }])
      end
    end
  end
end
