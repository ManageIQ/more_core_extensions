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
      Aaa::Bbb::Ccc::Ddd.in_namespace?(Aaa::Bbb).should be_true
    end

    it "Module in Module" do
      Aaa::Bbb::Ccc::Eee.in_namespace?("Aaa::Bbb").should be_true
    end

    it "Instance of Class" do
      Aaa::Bbb::Ccc::Ddd.new.in_namespace?(Aaa::Bbb).should be_true
    end

    it "Not in namespace" do
      Aaa::Bbb::Ccc::Eee.in_namespace?(Aaa::Bbb::Ccc::Ddd).should be_false
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
