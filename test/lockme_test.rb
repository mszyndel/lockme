require 'test_helper'
require 'logger'

describe Lockme do
  describe "#test" do
    it 'performs a GET request to /test' do
      Lockme::Request.stub(:perform, ->(method, path, *args) { return [method, path] }) do
        assert_equal(Lockme.test, ['get', "/test"])
      end
    end
  end

  describe "api_key accessors" do
    it 'sets and returns api key' do
      assert_nil Lockme.api_key
      Lockme.api_key = 'asdf'
      assert_equal Lockme.api_key, 'asdf'
    end
  end

  describe "api_secret accessors" do
    it 'sets and returns api secret' do
      assert_nil Lockme.api_secret
      Lockme.api_secret = 'qwerty'
      assert_equal Lockme.api_secret, 'qwerty'
    end
  end

  describe "logger accessors" do
    it 'sets and returns logger' do
      assert_nil Lockme.logger
      Lockme.logger = Logger.new(STDOUT)
      assert_instance_of Logger, Lockme.logger
    end
  end
end
