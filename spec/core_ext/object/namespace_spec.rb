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
end
