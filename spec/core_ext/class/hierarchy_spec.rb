require 'socket' # for a more interesting hierarchy for specs

describe Class do
  context "#descendant_get" do
    it "returns self if specified" do
      expect(IO.descendant_get("IO")).to eq(IO)
    end

    it "returns a direct descendant" do
      expect(IO.descendant_get("BasicSocket")).to eq(BasicSocket)
    end

    it "returns a transitive descendant" do
      expect(IO.descendant_get("IPSocket")).to eq(IPSocket)
    end

    it "raises an error on an invalid class" do
      expect { IO.descendant_get("Foo") }.to raise_error(ArgumentError, "Foo is not a descendant of IO")
    end

    it "raises an error on a valid module that is not a descendant" do
      expect { IO.descendant_get("MoreCoreExtensions") }.to raise_error(ArgumentError, "MoreCoreExtensions is not a descendant of IO")
    end

    it "raises an error on a valid class that is not a descendant" do
      expect { IO.descendant_get("String") }.to raise_error(ArgumentError, "String is not a descendant of IO")
    end
  end

  it "#hierarchy" do
    expect(IO.hierarchy).to eq(
      BasicSocket => {
        Socket     => {},
        IPSocket   => {TCPSocket => {TCPServer => {}}, UDPSocket => {}},
        UNIXSocket => {UNIXServer => {}}
      },
      File        => {}
    )
  end

  it "#lineage" do
    expect(TCPServer.lineage).to eq [TCPSocket, IPSocket, BasicSocket, IO, Object, BasicObject]
  end

  it "#leaf_subclasses" do
    expect(BasicSocket.leaf_subclasses).to match_array([Socket, TCPServer, UDPSocket, UNIXServer])
  end
end
