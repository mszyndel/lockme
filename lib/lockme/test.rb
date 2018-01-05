# frozen_string_literal: true

#:nodoc:
module Lockme
  # Mixin providing a method to test API connection
  module Test
    def test
      Lockme::SignedRequest.perform('get', '/test')
    end
  end
  private_constant :Test
end
