require 'socket' # for a more interesting hierarchy for specs

describe Class do
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
