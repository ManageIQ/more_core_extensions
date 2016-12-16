module MoreCoreExtensions
  module StringFormats
    # From: http://www.regular-expressions.info/email.html
    RE_EMAIL =  %r{\A[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\z}

    def email?
      !!(self =~ RE_EMAIL)
    end

    # From: Regular Expression Cookbook: 7.15 Validating Domain Names
    RE_DOMAINNAME = %r{^([a-z0-9]+(-[a-z0-9]+)*\.)+[a-z]{2,}$}i
    def domain_name?
      !!(self =~ RE_DOMAINNAME)
    end

    # From: Regular Expression Cookbook: 7.16 Matching IPv4 Addresses
    RE_IPV4 = %r{^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$}
    def ipv4?
      !!(self =~ RE_IPV4)
    end

    # From: Regular Expression Cookbook: 7.17 Matching IPv6 Addresses
    RE_IPV6 = %r{^(?:(?:(?:[A-F0-9]{1,4}:){6}|(?=(?:[A-F0-9]{0,4}:){0,6}(?:[0-9]{1,3}\.){3}[0-9]{1,3}$)(([0-9A-F]{1,4}:){0,5}|:)((:[0-9A-F]{1,4}){1,5}:|:))(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)|(?:[A-F0-9]{1,4}:){7}[A-F0-9]{1,4}|(?=(?:[A-F0-9]{0,4}:){0,7}[A-F0-9]{0,4}$)(([0-9A-F]{1,4}:){1,7}|:)((:[0-9A-F]{1,4}){1,7}|:))$}i
    def ipv6?
      !!(self =~ RE_IPV6)
    end

    def ipaddress?
      ipv4? || ipv6?
    end

    RE_INTEGER = %r{^-?[0-9]+$}
    def integer?
      !!(self =~ RE_INTEGER)
    end

    RE_GUID = /^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$/
    def guid?
      !!(self =~ RE_GUID)
    end
  end
end

String.send(:include, MoreCoreExtensions::StringFormats)
