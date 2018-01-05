require 'test_helper'

describe Lockme::Reservation do
  describe "#persisted?" do
    it "checks for reservationid" do
      new_reservation = Lockme::Reservation.new
      new_reservation.persisted?.must_equal false

      persisted_reservation = Lockme::Reservation.new(reservationid: 123)
      persisted_reservation.persisted?.must_equal true
    end
  end

  describe "#save" do
    it "calls #update when the object is persisted" do
      obj = Lockme::Reservation.new
      obj.stub :persisted?, true do
        obj.stub :update, 'update' do
          assert_equal(obj.save, 'update')
        end
      end
    end

    it "calls #create when the object is not persisted" do
      obj = Lockme::Reservation.new
      obj.stub :persisted?, false do
        obj.stub :create, 'create' do
          assert_equal(obj.save, 'create')
        end
      end
    end
  end

  describe "find" do
    it 'performs a GET request and returns a Reservation object' do
      lockme_id = 2753586
      Lockme::SignedRequest.stub(:perform, ->(*_args) { return { reservationid: 746269 } }) do
        obj = Lockme::Reservation.find(lockme_id)
        assert_instance_of(Lockme::Reservation, obj)
        assert_equal(obj.reservationid, 746269)
      end
    end
  end

  describe "#destroy" do
    it 'performs a DELETE request' do
      lockme_id = 2753586
      Lockme::SignedRequest.stub(:perform, ->(*args) { return args }) do
        resp = Lockme::Reservation.new(reservationid: lockme_id).destroy
        assert_equal(resp, ['delete', "/reservation/#{lockme_id}"])
      end
    end
  end

  describe "#create" do
    it 'performs a PUT request' do
      lockme_id = 2753586
      Lockme::SignedRequest.stub(:perform, ->(*args) { return args }) do
        resp = Lockme::Reservation.new(reservationid: lockme_id).send :create
        assert_instance_of(Lockme::Reservation, resp)
        assert_equal(resp.reservationid[0..1], ['put', "/reservation"])
      end
    end
  end

  describe "#update" do
    it 'performs a POST request' do
      lockme_id = 2753586
      Lockme::SignedRequest.stub(:perform, ->(*args) { return { reservationid: args } }) do
        resp = Lockme::Reservation.new(reservationid: lockme_id).send :update
        assert_instance_of(Lockme::Reservation, resp)
        assert_equal(resp.reservationid[0..1], ['post', "/reservation/#{lockme_id}"])
      end
    end
  end
end
