# MoreCoreExtensions

[![Join the chat at https://gitter.im/ManageIQ/more_core_extensions](https://badges.gitter.im/ManageIQ/more_core_extensions.svg)](https://gitter.im/ManageIQ/more_core_extensions?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

MoreCoreExtensions are a set of core extensions beyond those provided by ActiveSupport.

[![Gem Version](https://badge.fury.io/rb/more_core_extensions.svg)](http://badge.fury.io/rb/more_core_extensions)
[![Build Status](https://travis-ci.org/ManageIQ/more_core_extensions.svg?branch=master)](https://travis-ci.org/ManageIQ/more_core_extensions)
[![Code Climate](http://img.shields.io/codeclimate/github/ManageIQ/more_core_extensions.svg)](https://codeclimate.com/github/ManageIQ/more_core_extensions)
[![Coverage Status](http://img.shields.io/coveralls/ManageIQ/more_core_extensions.svg)](https://coveralls.io/r/ManageIQ/more_core_extensions)
[![Dependency Status](https://gemnasium.com/ManageIQ/more_core_extensions.svg)](https://gemnasium.com/ManageIQ/more_core_extensions)

## Extensions Provided

#### Array

* core_ext/array/deletes.rb
  * `#delete_blanks` - Deletes all items where the value is blank
  * `#delete_nils` - Deletes all items where the value is nil
* core_ext/array/duplicates.rb
  * `#duplicates` - Returns an Array of the duplicates found
* core_ext/array/element_counts.rb
  * `#element_counts` - Returns a Hash of each element to the count of those elements
* core_ext/array/inclusions.rb
  * `#include_all?` - Returns whether the Array contains all of the items
  * `#include_any?` - Returns whether the Array contains any of the items
  * `#include_none?` - Returns whether the Array contains none of the items
  * `#includes_index?` - Returns whether the Array has a value at the index
* core_ext/array/math.rb
  * `#mean` -  Returns the mean of an Array of Numerics
  * `#stddev` - Returns the standard deviation of an Array of Numerics
  * `#variance` - Returns the variance of an Array of Numerics
* core_ext/array/nested.rb (see [Shared](#shared))
  * `#delete_blank_paths` - Deletes all paths where the value is blank
* core_ext/array/random.rb
  * `#random_index` - Picks a valid index randomly
  * `#random_element` - Picks an element randomly
* core_ext/array/stretch.rb
  * `.stretch` - Stretch all argument Arrays to make them the same size
  * `.stretch!` - Stretch all argument Arrays to make them the same size. Modifies the arguments in place.
  * `#stretch` - Stretch receiver to be the same size as the longest argument Array.
  * `#stretch`! - Stretch receiver to be the same size as the longest argument Array.  Modifies the receiver in place.
  * `#zip_stretched` - Zip arguments stretching the receiver if necessary
* core_ext/array/tableize.rb
  * `#tableize` - Create a string representation of receiver in a tabular format if receiver is an Array of Arrays or an Array of Hashes

#### Class

* core_ext/class/hierarchy.rb
  * `#hierarchy` - Returns a tree-like Hash structure of all descendants.
  * `#lineage` - Returns an Array of all superclasses.

#### Hash

* core_ext/hash/deletes.rb
  * `#delete_blanks` - Deletes all keys where the value is blank
  * `#delete_nils` - Deletes all keys where the value is nil
* core_ext/hash/nested.rb (see [Shared](#shared))
  * `#delete_blank_paths` - Deletes all paths where the value is blank
* core_ext/hash/sorting.rb (see [Shared](#shared))
  * `#sort!` - Replace the original with the sorted hash
  * `#sort_by!` - Replace the original with the sorted_by hash

#### Module

* core_ext/module/cache_with_timeout.rb
  * `#cache_with_timeout` - Creates singleton methods that cache the results of the given block, but only for a short amount of time.
  * `.clear_all_cache_with_timeout` - Globally clears all cached values across all classes.
* core_ext/module/namespace.rb
  * `#namespace` - Returns an Array with the namespace to the current Module

#### Numeric

* core_ext/numeric/clamp.rb
  * `#clamp` - Clamp a number to a minimum and/or maximum value
* core_ext/numeric/math.rb
  * `#square` - Returns the square of a Numeric
* core_ext/numeric/rounding.rb
  * `#round_down` - Round down to the specified precision
  * `#round_up` - Round up to the specified precision

#### Object

* core_ext/module/descendants.rb
  * `#descendant_get` - Returns the descendant with a given name
* core_ext/module/namespace.rb
  * `#in_namespace?` - Returns whether or not the object is in the given namespace

#### Range

* core_ext/range/step_value.rb
  * `#step_value` - Step through a range at a given increment

#### String

* core_ext/string/decimal_suffix.rb
  * `#decimal_si_to_big_decimal` - Returns a BigDecimal based on the number and suffix given
  * `#decimal_si_to_f` - Returns a Float based on the number and suffix given
* core_ext/string/formats.rb
  * `#email?` - Returns whether or not the String is an= valid email
  * `#domain_name?` - Returns whether or not the String is a valid domain name
  * `#hostname?` - Returns whether or not the String is a valid hostname
  * `#ipv4?` - Returns whether or not the String is an IPv4 address
  * `#ipv6?` - Returns whether or not the String is an IPv6 address
  * `#ipaddress?` - Returns whether or not the String is an IPv4 or IPv6 address
  * `#integer?` - Returns whether or not the String is an integer
  * `#guid?` - Returns whether or not the String is a valid GUID
* core_ext/string/hex_dump.rb
  * `#hex_dump` - Dumps the string in a hex editor style format
* core_ext/string/iec60027_2.rb
  * `#iec_60027_2_to_i` - Convert strings with an IEC60027-2 suffix to an integer

#### Symbol

* core_ext/symbol/to_i.rb
  * `#to_i` - Returns the integer value of a symbol

#### Shared

* core_ext/shared/nested.rb
  * `#delete_path` - Delete the value at the specified nesting
  * `#fetch_path` - Fetch the value at the specified nesting
  * `#find_path` - Detect which nesting holds the specified value
  * `#has_key_path?` - Check if a key exists at the specified nesting
  * `#include_path?` - alias of `#has_key_path?`
  * `#key_path?` - alias of `#has_key_path?`
  * `#member_path?` - alias of `#has_key_path?`
  * `#store_path` - Store a value at the specified nesting

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

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
