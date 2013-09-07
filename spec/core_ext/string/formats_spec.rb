require_relative "../../spec_helper"

describe String do
  it '#email?' do
    "john@example.com".should be_email
    "john.doe@example.com".should be_email

    "john.doe@examplecom".should_not be_email
    "john.doe@example-com".should_not be_email
    "".should_not be_email
    "foo".should_not be_email
  end

  it '#domain_name?' do
    "example.com".should be_domain_name

    "example..com".should_not be_domain_name
    "john.doe@example.com".should_not be_domain_name
    "".should_not be_domain_name
    "foo".should_not be_domain_name
  end

  it '#ipv4?' do
    "192.168.252.15".should be_ipv4

    "392.168.252.15".should_not be_ipv4
    "".should_not be_ipv4
    "foo".should_not be_ipv4
    "::1".should_not be_ipv4                            # 127.0.0.1 in IPv6
    "1762:0:0:0:0:B03:1:AF18".should_not be_ipv4        # Standard Notation
    "1762:0:0:0:0:B03:127.32.67.15".should_not be_ipv4  # Mixed Notation
    "1762::B03:1:AF18".should_not be_ipv4               # Compressed Notation
  end

  it '#ipv6?' do
    "::1".should be_ipv6                            # 127.0.0.1 in IPv6
    "1762:0:0:0:0:B03:1:AF18".should be_ipv6        # Standard Notation
    "1762:0:0:0:0:B03:127.32.67.15".should be_ipv6  # Mixed Notation
    "1762::B03:1:AF18".should be_ipv6               # Compressed Notation

    "192.168.252.15".should_not be_ipv6
    "392.168.252.15".should_not be_ipv6
    "".should_not be_ipv6
    "foo".should_not be_ipv6
  end

  it "#ipaddress?" do
    "192.168.252.15".should be_ipaddress
    "::1".should be_ipaddress                            # 127.0.0.1 in IPv6
    "1762:0:0:0:0:B03:1:AF18".should be_ipaddress        # Standard Notation
    "1762:0:0:0:0:B03:127.32.67.15".should be_ipaddress  # Mixed Notation
    "1762::B03:1:AF18".should be_ipaddress               # Compressed Notation

    "392.168.252.15".should_not be_ipaddress
    "".should_not be_ipaddress
    "foo".should_not be_ipaddress
  end

  it "#integer?" do
    "100".should be_integer
    "-100".should be_integer

    "".should_not be_integer
    "100.2".should_not be_integer
    "A".should_not be_integer
    "100A".should_not be_integer
  end

  it '#guid?' do
    '01234567-89ab-cdef-abcd-ef0123456789'.should be_guid

    '012ZZZ67-89ab-cdef-abcd-ef0123456789'.should_not be_guid
    "".should_not be_guid
    "foo".should_not be_guid
  end
end