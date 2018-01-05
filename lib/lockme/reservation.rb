# frozen_string_literal: true

module Lockme
  # LockMe API reservation object
  class Reservation < Lockme::Base
    def initialize(args = {})
      parse_lockme_json(args)
    end

    def self.find(lockme_id)
      new(Lockme::SignedRequest.perform("get", "/reservation/#{lockme_id}"))
    end

    def save
      if persisted?
        update
      else
        create
      end
    end

    def destroy
      Lockme::SignedRequest.perform("delete", "/reservation/#{reservationid}")
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
      @data.reservationid = Lockme::SignedRequest.perform("put", "/reservation", to_json)
      self
    end
    private :create

    def update
      resp = Lockme::SignedRequest.perform("post", "/reservation/#{reservationid}", to_json)
      parse_lockme_json(resp)
      self
    end
    private :update

    def parse_lockme_json(data)
      @data = OpenStruct.new(data)
    end
    private :parse_lockme_json
  end
end
