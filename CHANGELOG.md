# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]

## [4.2.0] - 2020-07-20
### Added
- Add bundler-inject allowing developers to override dependencies [[#89](https://github.com/ManageIQ/more_core_extensions/pull/89)]
- Add Array and Hash #deep_clone and #deep_delete [[#91](https://github.com/ManageIQ/more_core_extensions/pull/91)]
- Add Digest::UUID.clean to properly format UUID strings [[#81](https://github.com/ManageIQ/more_core_extensions/pull/81)]

### Changed
- Update ArrayTableize to properly set field width for color text [[#87](https://github.com/ManageIQ/more_core_extensions/pull/87)]
- Change Array#format_table header output to markdown vs postgres [[#83](https://github.com/ManageIQ/more_core_extensions/pull/83)]

## [4.1.0] - 2020-04-30
### Added
- Added Ruby 2.7 support [[#79](https://github.com/ManageIQ/more_core_extensions/pull/79)]
- Added Process#pause, Process#resume, and Process#alive? [[#73](https://github.com/ManageIQ/more_core_extensions/pull/73)]

## [4.0.0] - 2020-01-31
### Changed
- **BREAKING**: Moved Object#descendant_get to Class#descendant_get [[#75](https://github.com/ManageIQ/more_core_extensions/pull/75)]
- **BREAKING**: Removed deprecated Enumerable#stable_sort_by [[#76](https://github.com/ManageIQ/more_core_extensions/pull/76)]

## [3.8.0] - 2020-01-31
### Changed
- Renamed Enumerable#stable_sort_by to Array#tabular_sort [[#68](https://github.com/ManageIQ/more_core_extensions/pull/68)]
- Deprecated Enumerable#stable_sort_by [[#74](https://github.com/ManageIQ/more_core_extensions/pull/74)]

### Added
- Added Class#leaf_subclasses [[#71](https://github.com/ManageIQ/more_core_extensions/pull/71)]
- Added Array#compact_map [[#63](https://github.com/ManageIQ/more_core_extensions/pull/63)]

## [3.7.0] - 2019-02-04
### Added
- Added Enumerable#stable_sort_by [[#67](https://github.com/ManageIQ/more_core_extensions/pull/67)]
- Added Math#slope_y_intercept, #slope_x_intercept, #linear_regression [[#50](https://github.com/ManageIQ/more_core_extensions/pull/50)]
- Added Benchmark#realtime_store, #realtime_block and helper methods [[#65](https://github.com/ManageIQ/more_core_extensions/pull/65)]
- Added Class#hierarchy and #lineage [[#61](https://github.com/ManageIQ/more_core_extensions/pull/61)]

## [3.6.0] - 2018-03-01
### Added
- Added String#decimal_si_to_big_decimal [[#59](https://github.com/ManageIQ/more_core_extensions/pull/59)]

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

[Unreleased]: https://github.com/ManageIQ/more_core_extensions/compare/v4.2.0...HEAD
[4.2.0]: https://github.com/ManageIQ/more_core_extensions/compare/v4.1.0...v4.2.0
[4.1.0]: https://github.com/ManageIQ/more_core_extensions/compare/v4.0.0...v4.1.0
[4.0.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.8.0...v4.0.0
[3.8.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.7.0...v3.8.0
[3.7.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.6.0...v3.7.0
[3.6.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.5.0...v3.6.0
[3.5.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.4.0...v3.5.0
[3.4.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.3.0...v3.4.0
[3.3.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.2.0...v3.3.0
[3.2.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.1.1...v3.2.0
[3.1.1]: https://github.com/ManageIQ/more_core_extensions/compare/v3.1.0...v3.1.1
[3.1.0]: https://github.com/ManageIQ/more_core_extensions/compare/v3.0.0...v3.1.0
[3.0.0]: https://github.com/ManageIQ/more_core_extensions/compare/v2.0.0...v3.0.0
[2.0.0]: https://github.com/ManageIQ/more_core_extensions/compare/v1.2.0...v2.0.0
