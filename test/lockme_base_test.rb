require 'test_helper'

describe Lockme::Base do
  describe "#to_json" do
    it "properly encodes UTF-8 characters" do
      encoded = Lockme::Reservation.new(first_name: "Michał", last_name: "Müller").to_json
      assert_equal encoded, "{\"first_name\":\"Micha\\u0142\",\"last_name\":\"M\\u00fcller\"}"
    end
  end
end
