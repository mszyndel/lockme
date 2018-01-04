require 'httparty'
require 'forwardable'

require 'lockme/configuration'
require 'lockme/json_utils'
require 'lockme/error'
require 'lockme/request'
require 'lockme/test'
require 'lockme/base'
require 'lockme/reservation'
require 'lockme/room'
require 'lockme/version'

module Lockme
  extend Configuration
  extend Test
end
