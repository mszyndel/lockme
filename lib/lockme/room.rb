# frozen_string_literal: true

module Lockme
  # LockMe API room collection
  class Room < Lockme::Base
    def self.all
      Lockme::SignedRequest.perform("get", "/rooms")
    end
  end
end
