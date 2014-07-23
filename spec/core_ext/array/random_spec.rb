require_relative "../../spec_helper"

describe Array do
  around do |example|
    old_seed = srand(12072)
    example.call
    srand(old_seed)
  end

  it '#random_index' do
    expect(20.times.collect { [].random_index }.uniq.sort).to          eq([nil])
    expect(20.times.collect { %w{a}.random_index }.uniq.sort).to       eq([0])
    expect(20.times.collect { %w{a b}.random_index }.uniq.sort).to     eq([0, 1])
    expect(20.times.collect { %w{a b c d}.random_index }.uniq.sort).to eq([0, 1, 2, 3])
  end

  it '#random_element' do
    expect(20.times.collect { [].random_element }.uniq.sort).to          eq([nil])
    expect(20.times.collect { %w{a}.random_element }.uniq.sort).to       eq(%w{a})
    expect(20.times.collect { %w{a b}.random_element }.uniq.sort).to     eq(%w{a b})
    expect(20.times.collect { %w{a b c d}.random_element }.uniq.sort).to eq(%w{a b c d})
  end
end
