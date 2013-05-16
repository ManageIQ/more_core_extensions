# MoreCoreExtensions

MoreCoreExtensions are a set of core extensions beyond those provided by ActiveSupport.

## Extensions Provided

* Array
  * duplicates
  * include_any?
  * include_none?
  * include_all?
  * random_index
  * random_element
  * stretch
  * stretch!
  * zip_stretched
  * tableize
* Hash
  * delete_nils
  * delete_blanks
  * fetch_path
  * has_key_path?
    * include_path?
    * key_path?
    * member_path?
  * store_path
  * delete_path
* String
  * email?
  * domain_name?
  * ipv4?
  * ipv6?
  * ipaddress?
  * integer?
  * guid?
  * hex_dump

## Installation

Add this line to your application's Gemfile:

    gem 'more_core_extensions'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install more_core_extensions

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
