module Lockme
  class Reservation
    def initialize(args = {})
      @data = args
    end

    def self.find(lockme_id)
      self.new(Lockme::Request.perform("get", "/reservation/#{lockme_id}"))
    end

    def save
      if(@data[:lockme_id].present?)
        update
      else
        create
      end
    end

    def destroy
      Lockme::Request.perform("delete", "/reservation/#{@data[:id]}")
    end

    def create
      Lockme::Request.perform("put", "/reservation", self.to_json)
    end
    private :create

    def update
      Lockme::Request.perform("post", "/reservation/#{self.id}", self.to_json)
    end
    private :update
  end
end
