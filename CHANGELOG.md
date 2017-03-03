# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [3.1.1] - 2016-12-16
### Changed
- Updated email Regex to be more accurate and slightly less restrictive

### Fixed
- Fixed issue where email Regex did not support more than 3 char TLDs

## [3.1.0] - 2016-08-11
### Added
- Add Array #deviation, #mean, #squares, #variance
- Add Numeric #square, #round_up, #round_down

## [3.0.0] - 2016-07-07
### Changed
- **BREAKING**: Drop support for Ruby 1.9.3 [[#22](https://github.com/ManageIQ/more_core_extensions/pull/22)]
- Drop dependency on ActiveSupport due to Rails 5 minimum Ruby version [[#22](https://github.com/ManageIQ/more_core_extensions/pull/22)]

## [2.0.0] - 2015-12-02
### Changed
- **BREAKING**: Remove Object#namespace [[#20](https://github.com/ManageIQ/more_core_extensions/pull/20)]
- Add ability to pass a transformation block to element_counts [[#21](https://github.com/ManageIQ/more_core_extensions/pull/21)]
- Array#include_any? and friends now accept a single argument Array. [[#18](https://github.com/ManageIQ/more_core_extensions/pull/18)]
- Upgraded to RSpec 3 [[#16](https://github.com/ManageIQ/more_core_extensions/pull/16)]
- Added the Change Log!

[Unreleased]: https://github.com/ManageIQ/more_core_extensions/compare/v3.1.0...HEAD
[3.1.1]: https://github.com/ManageIQ/more_core_extensions/compare/v3.1.0...v3.1.1
[3.1.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.0.0...v3.1.0
[3.0.0]: https://github.com/ManageIQ/more_core_extensions/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/ManageIQ/more_core_extensions/compare/v1.2.0...v2.0.0
