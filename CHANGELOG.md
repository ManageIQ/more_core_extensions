# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [3.1.0] - 2016-08-11
### Additions
- Add Array #deviation, #mean, #squares, #variance
- Add Numeric #square, #round_up, #round_down

## [3.0.0] - 2016-07-07
### Breaking changes
- Drop support for Ruby 1.9.3 [#22]

### Other changes
- Drop dependency on ActiveSupport due to Rails 5 minimum Ruby version [#22]

## [2.0.0] - 2015-12-02
### Breaking changes
- Remove Object#namespace [#20]

### Other changes
- Add ability to pass a transformation block to element_counts [#21]
- Array#include_any? and friends now accept a single argument Array. [#18]
- Upgraded to RSpec 3 [#16]
- Added the Change Log!
