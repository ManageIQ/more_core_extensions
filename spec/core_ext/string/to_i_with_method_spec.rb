require "active_support/core_ext/numeric/bytes"

RSpec.describe String do
  it '#to_i_with_method' do
    expect("20".to_i_with_method).to eql(20)
    expect("20.percent".to_i_with_method).to eql(20)
    expect("20.bytes".to_i_with_method).to eql(20)
    expect("20.megabytes".to_i_with_method).to eql(20_971_520)
    expect("20.1.megabytes".to_i_with_method).to eql(21_076_377)
    expect("123abc".to_i_with_method).to eql(123)
    expect("2.51234.megabytes".to_i_with_method).to eql(2_634_379)
    expect("2,000.megabytes".to_i_with_method).to eql(2_097_152_000)
  end

  it 'String#to_f_with_method' do
    expect("20".to_f_with_method).to eql(20.0)
    expect("20.percent".to_f_with_method).to eql(20.0)
    expect("20.1.percent".to_f_with_method).to eql(20.1)
    expect("20.bytes".to_f_with_method).to eql(20.0)
    expect("2.51234.megabytes".to_f_with_method).to eql(2_634_379.42784)
    expect("20.1.megabytes".to_f_with_method).to eql(21_076_377.6)
    expect("123abc".to_f_with_method).to eql(123.0)
    expect("2,000.megabytes".to_f_with_method).to eql(2_097_152_000.0)
  end

  it 'String#number_with_method?' do
    expect("20".number_with_method?).to              be_falsey
    expect("20.percent".number_with_method?).to      be_truthy
    expect("20.1.percent".number_with_method?).to    be_truthy
    expect("123abc".number_with_method?).to          be_falsey
    expect("2,000.megabytes".number_with_method?).to be_truthy
  end
end

RSpec.describe Numeric do
  it('Integer#to_i_with_method')    { expect(20.to_i_with_method).to eql(20) }
  it('Integer#to_f_with_method')    { expect(20.to_f_with_method).to eql(20.0) }
  it('Integer#number_with_method?') { expect(20.number_with_method?).to be_falsey }

  it('Float#to_i_with_method')    { expect(20.1.to_i_with_method).to eql(20) }
  it('Float#to_f_with_method')    { expect(20.1.to_f_with_method).to eql(20.1) }
  it('Float#number_with_method?') { expect(20.1.number_with_method?).to be_falsey }
end

RSpec.describe NilClass do
  it('#to_i_with_method')    { expect(nil.to_i_with_method).to eql(0) }
  it('#to_f_with_method')    { expect(nil.to_f_with_method).to eql(0.0) }
  it('#number_with_method?') { expect(nil.number_with_method?).to be_falsey }
end

RSpec.describe Object do
  it '#number_with_method?' do
    expect(Object.new.number_with_method?).to be_falsey
    expect({}.number_with_method?).to         be_falsey
  end
end
