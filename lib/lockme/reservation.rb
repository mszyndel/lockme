module Lockme
  class Reservation < Lockme::Base
    def initialize(args = {})
      parse_lockme_json(args)
    end

    def self.find(lockme_id)
      self.new(Lockme::SignedRequest.perform("get", "/reservation/#{lockme_id}"))
    end

    def save
      if persisted?
        update
      else
        create
      end
    end

    def destroy
      Lockme::SignedRequest.perform("delete", "/reservation/#{@data.reservationid}")
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
      @data.reservationid = Lockme::SignedRequest.perform("put", "/reservation", self.to_json)
      return self
    end
    private :create

    def update
      resp = Lockme::SignedRequest.perform("post", "/reservation/#{@data.reservationid}", self.to_json)
      parse_lockme_json(resp)
      return self
    end
    private :update

    def parse_lockme_json(data)
      @data = OpenStruct.new(data)
    end
    private :parse_lockme_json
  end
end
