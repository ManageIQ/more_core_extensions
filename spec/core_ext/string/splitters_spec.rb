require_relative "../../spec_helper"

describe String do
  let(:str) { "This is a test of the emergency broadcast system. This is only a test." }

  context "#lsplit" do
    it "with no arguments" do
      expect { str.lsplit }.to raise_error(ArgumentError)
    end

    it "with one argument" do
      desired_array = ["This is a test of the emergency broadcast system", " This is only a test"]
      expect(str.lsplit(".")).to eq(desired_array)
    end

    it "fewer desired items than available" do
      desired_array = ["This", "is", "a test of the emergency broadcast system. This is only a test."]
      expect(str.lsplit(" ", 3)).to eq(desired_array)
    end

    it "more desired items than available" do
      result_array = str.lsplit(".", 5)
      desired_array = ["This is a test of the emergency broadcast system", " This is only a test", "", "", ""]
      expect(result_array).to eq(desired_array)
    end
  end

  context "#rsplit" do
    it "with no arguments" do
      expect { str.rsplit }.to raise_error(ArgumentError)
    end

    it "with one argument" do
      desired_array = ["This is a test of the emergency broadcast system", " This is only a test", ""]
      expect(str.rsplit(".")).to eq(desired_array)
    end

    it "fewer desired items than available" do
      desired_array = ["This is a test of the emergency broadcast system. This is only", "a", "test."]
      expect(str.rsplit(" ", 3)).to eq(desired_array)
    end

    it "more desired items than available" do
      result_array = str.rsplit(".", 5)
      desired_array = ["", "", "This is a test of the emergency broadcast system", " This is only a test", ""]
      expect(result_array).to eq(desired_array)
    end
  end
end