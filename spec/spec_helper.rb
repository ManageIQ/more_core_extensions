begin
  require 'coveralls'
  Coveralls.wear!
rescue LoadError
end

$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "more_core_extensions/all"
