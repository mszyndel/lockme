# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'lockme'

require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
