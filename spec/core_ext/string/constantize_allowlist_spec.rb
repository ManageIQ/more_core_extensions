describe String do
  describe "#constantize" do
    context "without allowlist" do
      it "constantizes a valid constant" do
        expect("String".constantize).to eq(String)
        expect("Array".constantize).to eq(Array)
        expect("Hash".constantize).to eq(Hash)
      end

      it "raises NameError for invalid constant" do
        expect { "NonExistentClass".constantize }.to raise_error(NameError)
      end
    end

    context "with allowlist as an Array of Strings" do
      context "when the String is in the allowlist" do
        it "constantizes the constant" do
          expect("String".constantize(:allowlist => ["String"])).to eq(String)
          expect("Array".constantize(:allowlist => ["String", "Array"])).to eq(Array)
        end
      end

      context "when the String is not in the allowlist" do
        it "raises NameError" do
          expect { "String".constantize(:allowlist => ["Array"]) }.to raise_error(NameError, "String not found in allowlist")
          expect { "Hash".constantize(:allowlist => ["String", "Array"]) }.to raise_error(NameError, "Hash not found in allowlist")
        end
      end
    end

    context "with allowlist as an Array of Classes" do
      context "when the String is in the allowlist" do
        it "constantizes the constant" do
          expect("String".constantize(:allowlist => [String])).to eq(String)
          expect("Array".constantize(:allowlist => [String, Array])).to eq(Array)
        end
      end

      context "when the String is not in the allowlist" do
        it "raises NameError" do
          expect { "String".constantize(:allowlist => [Array]) }.to raise_error(NameError, "String not found in allowlist")
          expect { "Hash".constantize(:allowlist => [String, Array]) }.to raise_error(NameError, "Hash not found in allowlist")
        end
      end
    end

    context "with mixed allowlist of Strings and Classes" do
      it "handles mixed types correctly" do
        expect("String".constantize(:allowlist => [String, "Array"])).to eq(String)
        expect("Array".constantize(:allowlist => [String, "Array"])).to eq(Array)
      end
    end

    context "with namespaced constants" do
      context "without allowlist" do
        it "constantizes namespaced constants" do
          expect("Encoding::Converter".constantize).to eq(Encoding::Converter)
          expect("Encoding::InvalidByteSequenceError".constantize).to eq(Encoding::InvalidByteSequenceError)
        end
      end

      context "with allowlist as Strings" do
        it "allows namespaced constants in allowlist" do
          expect("Encoding::Converter".constantize(:allowlist => ["Encoding::Converter"])).to eq(Encoding::Converter)
          expect("Encoding::InvalidByteSequenceError".constantize(:allowlist => ["Encoding::InvalidByteSequenceError"])).to eq(Encoding::InvalidByteSequenceError)
        end

        it "raises NameError when namespaced constant not in allowlist" do
          expect { "Encoding::Converter".constantize(:allowlist => ["String"]) }.to raise_error(NameError, "Encoding::Converter not found in allowlist")
        end
      end

      context "with allowlist as Classes" do
        it "allows namespaced constants in allowlist" do
          expect("Encoding::Converter".constantize(:allowlist => [Encoding::Converter])).to eq(Encoding::Converter)
          expect("Encoding::InvalidByteSequenceError".constantize(:allowlist => [Encoding::InvalidByteSequenceError])).to eq(Encoding::InvalidByteSequenceError)
        end

        it "raises NameError when namespaced constant not in allowlist" do
          expect { "Encoding::Converter".constantize(:allowlist => [String]) }.to raise_error(NameError, "Encoding::Converter not found in allowlist")
        end
      end
    end
  end

  describe "#safe_constantize" do
    context "without allowlist" do
      it "constantizes a valid constant" do
        expect("String".safe_constantize).to eq(String)
        expect("Array".safe_constantize).to eq(Array)
        expect("Hash".safe_constantize).to eq(Hash)
      end

      it "returns nil for invalid constant" do
        expect("NonExistentClass".safe_constantize).to be_nil
      end
    end

    context "with allowlist as an Array of Strings" do
      context "when the String is in the allowlist" do
        it "constantizes the constant" do
          expect("String".safe_constantize(:allowlist => ["String"])).to eq(String)
          expect("Array".safe_constantize(:allowlist => ["String", "Array"])).to eq(Array)
        end
      end

      context "when the String is not in the allowlist" do
        it "returns nil" do
          expect("String".safe_constantize(:allowlist => ["Array"])).to be_nil
          expect("Hash".safe_constantize(:allowlist => ["String", "Array"])).to be_nil
        end
      end
    end

    context "with allowlist as an Array of Classes" do
      context "when the String is in the allowlist" do
        it "constantizes the constant" do
          expect("String".safe_constantize(:allowlist => [String])).to eq(String)
          expect("Array".safe_constantize(:allowlist => [String, Array])).to eq(Array)
        end
      end

      context "when the String is not in the allowlist" do
        it "returns nil" do
          expect("String".safe_constantize(:allowlist => [Array])).to be_nil
          expect("Hash".safe_constantize(:allowlist => [String, Array])).to be_nil
        end
      end
    end

    context "with mixed allowlist of Strings and Classes" do
      it "handles mixed types correctly" do
        expect("String".safe_constantize(:allowlist => [String, "Array"])).to eq(String)
        expect("Array".safe_constantize(:allowlist => [String, "Array"])).to eq(Array)
      end
    end

    context "when constant does not exist" do
      it "returns nil even with allowlist" do
        expect("NonExistentClass".safe_constantize(:allowlist => ["NonExistentClass"])).to be_nil
      end
    end

    context "with namespaced constants" do
      context "without allowlist" do
        it "constantizes namespaced constants" do
          expect("Encoding::Converter".safe_constantize).to eq(Encoding::Converter)
          expect("Encoding::InvalidByteSequenceError".safe_constantize).to eq(Encoding::InvalidByteSequenceError)
        end
      end

      context "with allowlist as Strings" do
        it "allows namespaced constants in allowlist" do
          expect("Encoding::Converter".safe_constantize(:allowlist => ["Encoding::Converter"])).to eq(Encoding::Converter)
          expect("Encoding::InvalidByteSequenceError".safe_constantize(:allowlist => ["Encoding::InvalidByteSequenceError"])).to eq(Encoding::InvalidByteSequenceError)
        end

        it "returns nil when namespaced constant not in allowlist" do
          expect("Encoding::Converter".safe_constantize(:allowlist => ["String"])).to be_nil
        end
      end

      context "with allowlist as Classes" do
        it "allows namespaced constants in allowlist" do
          expect("Encoding::Converter".safe_constantize(:allowlist => [Encoding::Converter])).to eq(Encoding::Converter)
          expect("Encoding::InvalidByteSequenceError".safe_constantize(:allowlist => [Encoding::InvalidByteSequenceError])).to eq(Encoding::InvalidByteSequenceError)
        end

        it "returns nil when namespaced constant not in allowlist" do
          expect("Encoding::Converter".safe_constantize(:allowlist => [String])).to be_nil
        end
      end

      context "when namespaced constant does not exist" do
        it "returns nil even with allowlist" do
          expect("Encoding::NonExistent".safe_constantize(:allowlist => ["Encoding::NonExistent"])).to be_nil
        end
      end
    end
  end
end
