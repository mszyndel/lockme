module Lockme
  class Room < Lockme::Base
    def self.all
      Lockme::SignedRequest.perform("get", "/rooms")
    end
  end
end
