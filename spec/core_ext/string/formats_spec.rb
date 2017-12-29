describe String do
  it '#email?' do
    expect("john@example.com").to be_email
    expect("john.doe@example.com").to be_email
    expect("john.doe@my-company.prestidigitation").to be_email
    expect("john.o'doe@example.com").to be_email
    expect("john.doe@EXAMPLE.COM").to be_email
    expect("John.Doe@example.com").to be_email

    expect("john\ndoe@example.com").not_to be_email
    expect("").not_to be_email
    expect("foo").not_to be_email
  end

  it '#domain_name?' do
    expect("example.com").to be_domain_name

    expect("example..com").not_to be_domain_name
    expect("john.doe@example.com").not_to be_domain_name
    expect("").not_to be_domain_name
    expect("foo").not_to be_domain_name
  end

  it '#hostname?' do
    expect("$").not_to be_hostname
    expect("-hostname").not_to be_hostname
    expect("10.10.10.10").not_to be_hostname

    expect("h").to be_hostname
    expect("hostname").to be_hostname
    expect("host.name").to be_hostname
    expect("host-name").to be_hostname
  end

  it '#ipv4?' do
    expect("192.168.252.15").to be_ipv4

    expect("392.168.252.15").not_to be_ipv4
    expect("").not_to be_ipv4
    expect("foo").not_to be_ipv4
    expect("::1").not_to be_ipv4                            # 127.0.0.1 in IPv6
    expect("1762:0:0:0:0:B03:1:AF18").not_to be_ipv4        # Standard Notation
    expect("1762:0:0:0:0:B03:127.32.67.15").not_to be_ipv4  # Mixed Notation
    expect("1762::B03:1:AF18").not_to be_ipv4               # Compressed Notation
  end

  it '#ipv6?' do
    expect("::1").to be_ipv6                            # 127.0.0.1 in IPv6
    expect("1762:0:0:0:0:B03:1:AF18").to be_ipv6        # Standard Notation
    expect("1762:0:0:0:0:B03:127.32.67.15").to be_ipv6  # Mixed Notation
    expect("1762::B03:1:AF18").to be_ipv6               # Compressed Notation

    expect("192.168.252.15").not_to be_ipv6
    expect("392.168.252.15").not_to be_ipv6
    expect("").not_to be_ipv6
    expect("foo").not_to be_ipv6
  end

  it "#ipaddress?" do
    expect("192.168.252.15").to be_ipaddress
    expect("::1").to be_ipaddress                            # 127.0.0.1 in IPv6
    expect("1762:0:0:0:0:B03:1:AF18").to be_ipaddress        # Standard Notation
    expect("1762:0:0:0:0:B03:127.32.67.15").to be_ipaddress  # Mixed Notation
    expect("1762::B03:1:AF18").to be_ipaddress               # Compressed Notation

    expect("392.168.252.15").not_to be_ipaddress
    expect("").not_to be_ipaddress
    expect("foo").not_to be_ipaddress
  end

  it "#integer?" do
    expect("100").to be_integer
    expect("-100").to be_integer

    expect("").not_to be_integer
    expect("100.2").not_to be_integer
    expect("A").not_to be_integer
    expect("100A").not_to be_integer
  end

  it '#guid?' do
    expect('01234567-89ab-cdef-abcd-ef0123456789').to be_guid

    expect('012ZZZ67-89ab-cdef-abcd-ef0123456789').not_to be_guid
    expect("").not_to be_guid
    expect("foo").not_to be_guid
  end
end
