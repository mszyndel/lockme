module Lockme
  module Test
    def test
      Lockme::SignedRequest.perform('get', '/test')
    end
  end
  private_constant :Test
end
