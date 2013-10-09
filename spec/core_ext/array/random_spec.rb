require_relative "../../spec_helper"

describe Array do
  around do |example|
    old_seed = srand(12072)
    example.call
    srand(old_seed)
  end

  it '#random_index' do
    20.times.collect { [].random_index }.uniq.sort.should          == [nil]
    20.times.collect { %w{a}.random_index }.uniq.sort.should       == [0]
    20.times.collect { %w{a b}.random_index }.uniq.sort.should     == [0, 1]
    20.times.collect { %w{a b c d}.random_index }.uniq.sort.should == [0, 1, 2, 3]
  end

  it '#random_element' do
    20.times.collect { [].random_element }.uniq.sort.should          == [nil]
    20.times.collect { %w{a}.random_element }.uniq.sort.should       == %w{a}
    20.times.collect { %w{a b}.random_element }.uniq.sort.should     == %w{a b}
    20.times.collect { %w{a b c d}.random_element }.uniq.sort.should == %w{a b c d}
  end
end
