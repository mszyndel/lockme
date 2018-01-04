module Lockme
  class Room
    def self.all
      Lockme::Request.perform("get", "/rooms")
    end
  end
end
