module Lockme
  class Room < Lockme::Base
    def self.all
      Lockme::Request.perform("get", "/rooms")
    end
  end
end
