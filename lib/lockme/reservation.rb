module Lockme
  class Reservation < Lockme::Base
    def initialize(args = {})
      @data = OpenStruct.new(args)
    end

    def self.find(lockme_id)
      self.new(Lockme::Request.perform("get", "/reservation/#{lockme_id}"))
    end

    def save
      if persisted?
        update
      else
        create
      end
    end

    def destroy
      Lockme::Request.perform("delete", "/reservation/#{@data.reservationid}")
    end

    # Check if object is persisted with Lockme
    def persisted?
      !@data.reservationid.nil?
    end

    # Provide attribute accessors
    def method_missing(method, *args)  
      @data.send method, *args
    end

    def create
      Lockme::Request.perform("put", "/reservation", self.to_json)
    end
    private :create

    def update
      Lockme::Request.perform("post", "/reservation/#{@data.reservationid}", self.to_json)
    end
    private :update
  end
end
