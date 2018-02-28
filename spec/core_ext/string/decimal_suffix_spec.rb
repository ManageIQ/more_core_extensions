# -*- coding: utf-8 -*-
describe String do
  INPUTS_AND_EXPECTED_PATTERNS = {
    # These are unsafe to be computed via integer * factor.
    # Each would fail for some i, j, for example 87 * 0.001 != 0.087.
    "ijf"   => "0.000_000_000_000_0ij",
    "ijp"   => "0.000_000_000_0ij",
    "ijn"   => "0.000_000_0ij",
    "ijμ"   => "0.000_0ij",
    "ijm"   => "0.0ij",
    "ijc"   => "0.ij",
    "ijd"   => "i.j",

    # These are less sensitive, safe to compute by multiplication.
    "ij"    => "ij.0",
    "ijk"   => "ij_000.0",
    "ijM"   => "ij_000_000.0",
    "ijG"   => "ij_000_000_000.0",
    "ijT"   => "ij_000_000_000_000.0",
    "ijP"   => "ij_000_000_000_000_000.0",
    "ijE"   => "ij_000_000_000_000_000_000.0",

    # Not SI suffixes, just fallback to ruby float parsing.
    "ije9"  => "ij_000_000_000.0",
    "0i.j0" => "i.j",
    "ije-9" => "0.000_000_0ij",
  }.freeze

  def each_ij(input_ij, expected_ij)
    (0..9).each do |i|
      (0..9).each do |j|
        yield(input_ij.sub("i", i.to_s).sub("j", j.to_s),
              expected_ij.delete("_").sub("i", i.to_s).sub("j", j.to_s))
      end
    end
  end

  INPUTS_AND_EXPECTED_PATTERNS.each do |input_ij, expected_ij|
    it "#{input_ij.inspect}.decimal_si_to_f -> #{expected_ij} for all i,j" do
      each_ij(input_ij, expected_ij) do |input, expected_as_string|
        actual = input.decimal_si_to_f
        expect(actual).to be_a(Float)
        expect(actual).to eq(Float(expected_as_string))
      end
    end
  end

  def strip_zeros(digits)
    expect(digits).to include(".")
    digits.sub(/^0*/, "").sub(/0*$/, "")
  end

  INPUTS_AND_EXPECTED_PATTERNS.each do |input_ij, expected_ij|
    it "#{input_ij.inspect}.decimal_si_to_big_decimal -> #{expected_ij} for all i,j" do
      each_ij(input_ij, expected_ij) do |input, expected_as_string|
        actual = input.decimal_si_to_big_decimal
        expect(actual).to be_a(BigDecimal)
        expect(actual).to eq(BigDecimal(expected_as_string))
        expect(strip_zeros(actual.to_s("F"))).to eq(strip_zeros(expected_as_string))
      end
    end
  end
end
