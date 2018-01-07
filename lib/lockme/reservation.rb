# frozen_string_literal: true

module Lockme
  # LockMe API reservation object
  class Reservation < Lockme::Base
    @base_path = '/reservation'

    def initialize(args = {})
      parse_lockme_json(args)
    end

    def id
      reservationid
    end

    def self.find(lockme_id)
      new(SignedRequest.perform("get", singular_path(lockme_id)))
    end

    def save
      if persisted?
        update
      else
        create
      end
    end

    def destroy
      SignedRequest.perform("delete", singular_path)
    end

    # Provide attribute accessors
    def method_missing(method, *args)
      @data.send method, *args
    end

    def create
      resp = SignedRequest.perform("put", collection_path, to_json)
      @data.reservationid = resp
      self
    end
    private :create

    def update
      resp = SignedRequest.perform("post", singular_path, to_json)
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
