require "spec_helper"

describe Class do
  before do
    module Aaa
      module Bbb
        module Ccc
          class  Ddd; end
          module Eee; end
        end
      end
    end
  end

  context "in_namespace?" do
    it "Class in Module" do
      expect(Aaa::Bbb::Ccc::Ddd.in_namespace?(Aaa::Bbb)).to be_truthy
    end

    it "Module in Module" do
      expect(Aaa::Bbb::Ccc::Eee.in_namespace?("Aaa::Bbb")).to be_truthy
    end

    it "Instance of Class" do
      expect(Aaa::Bbb::Ccc::Ddd.new.in_namespace?(Aaa::Bbb)).to be_truthy
    end

    it "Not in namespace" do
      expect(Aaa::Bbb::Ccc::Eee.in_namespace?(Aaa::Bbb::Ccc::Ddd)).to be_falsey
    end
  end

  context "namespace" do
    it "Class in Module" do
      expect(Aaa::Bbb::Ccc::Ddd.namespace).to eq(["Aaa", "Bbb", "Ccc", "Ddd"])
    end

    it "Module in Module" do
      expect(Aaa::Bbb::Ccc::Eee.namespace).to eq(["Aaa", "Bbb", "Ccc", "Eee"])
    end

    it "Instance of a Class" do
      expect(Aaa::Bbb::Ccc::Ddd.new.namespace).to eq(["Aaa", "Bbb", "Ccc", "Ddd"])
    end
  end
end
