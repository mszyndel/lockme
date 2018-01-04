module Lockme
  module Test
    def test
      Lockme::Request.perform('get', '/test')
    end
  end
  private_constant :Test
end
