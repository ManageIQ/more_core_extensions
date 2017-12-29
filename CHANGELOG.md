# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [3.5.0] - 2017-12-29
### Added
- Added String#hostname? [[#58](https://github.com/ManageIQ/more_core_extensions/pull/58)]

## [3.4.0] - 2017-08-11
### Added
- Added Module#cache_with_timeout [[#51](https://github.com/ManageIQ/more_core_extensions/pull/51)]

### Changed
- Performance improvements to store_path [[#54](https://github.com/ManageIQ/more_core_extensions/pull/54)]
  and fetch_path [[#55](https://github.com/ManageIQ/more_core_extensions/pull/55)]

## [3.3.0] - 2017-07-21
### Added
- Added Symbol#to_i [[#49](https://github.com/ManageIQ/more_core_extensions/pull/49)]
- Added Range#step_value [[#47](https://github.com/ManageIQ/more_core_extensions/pull/47)]
- Added Hash#sort! & #sort_by! [[#46](https://github.com/ManageIQ/more_core_extensions/pull/46)]
- Added Object.descendant_get [[#45](https://github.com/ManageIQ/more_core_extensions/pull/45)]
- Added String#decimal_si_to_f [[#43](https://github.com/ManageIQ/more_core_extensions/pull/43)]

## [3.2.0] - 2017-03-03
### Added
- Added Numeric#clamp [[#30](https://github.com/ManageIQ/more_core_extensions/pull/30)]
- Added String#to_iec_integer [[#24](https://github.com/ManageIQ/more_core_extensions/pull/24)]

### Changed
- Updated email Regex to allow mixed case [[#39](https://github.com/ManageIQ/more_core_extensions/pull/39)]

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

[Unreleased]: https://github.com/ManageIQ/more_core_extensions/compare/v3.5.0...HEAD
[3.5.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.4.0...v3.5.0
[3.4.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.3.0...v3.4.0
[3.3.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.2.0...v3.3.0
[3.2.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.1.1...v3.2.0
[3.1.1]: https://github.com/ManageIQ/more_core_extensions/compare/v3.1.0...v3.1.1
[3.1.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.0.0...v3.1.0
[3.0.0]: https://github.com/ManageIQ/more_core_extensions/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/ManageIQ/more_core_extensions/compare/v1.2.0...v2.0.0
