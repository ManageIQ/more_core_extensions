require 'more_core_extensions/core_ext/hash/jason'

describe Hash do
  it "#to_jason" do
    expect({}.to_json).to eq("{}")
    expect({}.to_jason).to eq("{}")
    expect({:a => 1}.to_jason).to eq('{"a":1}')
    expect({:c => nil}.to_jason).to eq('{"c":null}')
    expect({:a => 1, :b => [], :c => nil}.to_jason).to eq('{"a":1,"b":[],"c":null}')
  end
end
