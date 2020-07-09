describe Digest::UUID do
  context "clean" do
    let(:expected) { '01234567-89ab-cdef-abcd-ef0123456789' }

    it "handles a valid lowercase guid" do
      expect(described_class.clean('01234567-89ab-cdef-abcd-ef0123456789')).to eq(expected)
    end

    it "handles a Microsoft-style guid" do
      expect(described_class.clean('{01234567-89ab-cdef-abcd-ef0123456789}')).to eq(expected)
    end

    it "handles a valid uppercase guid" do
      expect(described_class.clean('01234567-89AB-CDEF-abcd-ef0123456789')).to eq(expected)
    end

    it "handles a valid guid with an invalid structure" do
      expect(described_class.clean('01 23 45 67 89 AB CD EF-AB CD EF 01 23 45 67 89')).to eq(expected)
    end

    it "handles an explicit nil or blank string" do
      expect(described_class.clean(nil)).to be_nil
      expect(described_class.clean('')).to be_nil
    end

    it "handles invalid guids" do
      expect(described_class.clean('sdkjfLSDLK')).to be_nil
      expect(described_class.clean('sdkjfLSD-LKJF-8367-41df-FLKD209alkfd')).to be_nil
      expect(described_class.clean('01234567-89AB-CDEF-abcd-efgggggggggg')).to be_nil
      expect(described_class.clean('01234567-89AB-CDEF-abcd-ef0123456789a')).to be_nil
      expect(described_class.clean('01234567-89AB-CDEF-abcd-ef012345678')).to be_nil
    end
  end
end
