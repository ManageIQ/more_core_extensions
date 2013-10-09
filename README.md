# MoreCoreExtensions

MoreCoreExtensions are a set of core extensions beyond those provided by ActiveSupport.

[![Gem Version](https://badge.fury.io/rb/more_core_extensions.png)](http://badge.fury.io/rb/more_core_extensions)
[![Build Status](https://travis-ci.org/ManageIQ/more_core_extensions.png?branch=master)](https://travis-ci.org/ManageIQ/more_core_extensions)
[![Code Climate](https://codeclimate.com/github/ManageIQ/more_core_extensions.png)](https://codeclimate.com/github/ManageIQ/more_core_extensions)
[![Coverage Status](https://coveralls.io/repos/ManageIQ/more_core_extensions/badge.png)](https://coveralls.io/r/ManageIQ/more_core_extensions)
[![Dependency Status](https://gemnasium.com/ManageIQ/more_core_extensions.png)](https://gemnasium.com/ManageIQ/more_core_extensions)

## Extensions Provided

* Array
  * delete_nils
  * delete_blanks
  * delete_blank_paths
  * duplicates
  * delete_path
  * include_any?
  * include_none?
  * include_all?
  * fetch_path
  * find_path
  * has_key_path?
    * include_path?
    * key_path?
    * member_path?
  * random_index
  * random_element
  * store_path
  * stretch
  * stretch!
  * zip_stretched
  * tableize
* Hash
  * delete_nils
  * delete_blanks
  * delete_blank_paths
  * delete_path
  * fetch_path
  * find_path
  * has_key_path?
    * include_path?
    * key_path?
    * member_path?
  * store_path
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
