describe String do
  it '#iec60027_2' do
    expect("1   ".iec_60027_2_to_i).to eq(1)
    expect("1 Ki".iec_60027_2_to_i).to eq(1_024)
    expect("1 Mi".iec_60027_2_to_i).to eq(1_048_576)
    expect("1 Gi".iec_60027_2_to_i).to eq(1_073_741_824)
    expect("1 Ti".iec_60027_2_to_i).to eq(1_099_511_627_776)
    expect("1 Pi".iec_60027_2_to_i).to eq(1_125_899_906_842_624)
    expect("1 Ei".iec_60027_2_to_i).to eq(1_152_921_504_606_846_976)
    expect("1 Zi".iec_60027_2_to_i).to eq(1_180_591_620_717_411_303_424)
    expect("1 Yi".iec_60027_2_to_i).to eq(1_208_925_819_614_629_174_706_176)

    expect("1.5 Ki".iec_60027_2_to_i).to eq(1_536)
    expect("8.1999999 Mi".iec_60027_2_to_i).to eq(8_598_323)
  end
end
