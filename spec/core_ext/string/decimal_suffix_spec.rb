describe String do
  it '#decimal_si_to_f' do
    expect("1f".decimal_si_to_f).to eq(0.000_000_000_000_001)
    expect("1p".decimal_si_to_f).to eq(0.000_000_000_001)
    expect("1n".decimal_si_to_f).to eq(0.000_000_001)
    expect("1μ".decimal_si_to_f).to eq(0.000_001)
    expect("1m".decimal_si_to_f).to eq(0.001)
    expect("1c".decimal_si_to_f).to eq(0.01)
    expect("1d".decimal_si_to_f).to eq(0.1)
    expect("1".decimal_si_to_f).to  eq(1.0)
    expect("1k".decimal_si_to_f).to eq(1_000.0)
    expect("1M".decimal_si_to_f).to eq(1_000_000.0)
    expect("1G".decimal_si_to_f).to eq(1_000_000_000.0)
    expect("1T".decimal_si_to_f).to eq(1_000_000_000_000.0)
    expect("1P".decimal_si_to_f).to eq(1_000_000_000_000_000.0)
    expect("1E".decimal_si_to_f).to eq(1_000_000_000_000_000_000.0)

    expect("1e9".decimal_si_to_f).to eq(1_000_000_000.0)
    expect("1e-9".decimal_si_to_f).to eq(0.000_000_001)
  end
end
