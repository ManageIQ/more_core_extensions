# MoreCoreExtensions

[![Join the chat at https://gitter.im/ManageIQ/more_core_extensions](https://badges.gitter.im/ManageIQ/more_core_extensions.svg)](https://gitter.im/ManageIQ/more_core_extensions?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

MoreCoreExtensions are a set of core extensions beyond those provided by ActiveSupport.

[![Gem Version](https://badge.fury.io/rb/more_core_extensions.svg)](http://badge.fury.io/rb/more_core_extensions)
[![Build Status](https://travis-ci.org/ManageIQ/more_core_extensions.svg?branch=master)](https://travis-ci.org/ManageIQ/more_core_extensions)
[![Code Climate](http://img.shields.io/codeclimate/github/ManageIQ/more_core_extensions.svg)](https://codeclimate.com/github/ManageIQ/more_core_extensions)
[![Coverage Status](http://img.shields.io/coveralls/ManageIQ/more_core_extensions.svg)](https://coveralls.io/r/ManageIQ/more_core_extensions)
[![Dependency Status](https://gemnasium.com/ManageIQ/more_core_extensions.svg)](https://gemnasium.com/ManageIQ/more_core_extensions)

## Extensions Provided

* Array
  * delete_nils
  * delete_blanks
  * delete_blank_paths
  * delete_path
  * deviation
  * duplicates
  * include_any?
  * include_none?
  * include_all?
  * fetch_path
  * find_path
  * has_key_path?
    * include_path?
    * key_path?
    * member_path?
  * mean
  * random_index
  * random_element
  * squares
  * store_path
  * stretch
  * stretch!
  * zip_stretched
  * tableize
  * variance
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
* Numeric
  * square
  * round_down
  * round_up
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
