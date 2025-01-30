require "logger" # Require logger due to active_support breaking on Rails <= 7.0. See https://github.com/rails/rails/pull/54264
require 'active_support'
require 'active_support/core_ext/object/blank'
require 'more_core_extensions/core_ext/object/deep_send'
require 'more_core_extensions/core_ext/object/namespace'
