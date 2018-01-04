require 'test_helper'
require 'logger'

describe Lockme do
  before do
    Lockme.api_key = nil
    Lockme.api_secret = nil
  end

  describe "#test" do
    it 'performs a GET request to /test' do
      Lockme::SignedRequest.stub(:perform, ->(method, path, *args) { return [method, path] }) do
        assert_equal(Lockme.test, ['get', "/test"])
      end
    end
  end

  describe "api_key accessors" do
    it 'sets and returns api key' do
      assert_nil Lockme.api_key
      Lockme.api_key = '9f37c75740e1a46086d137a29995ab2cf24fd209'
      assert_equal Lockme.api_key, '9f37c75740e1a46086d137a29995ab2cf24fd209'
    end
  end

  describe "api_secret accessors" do
    it 'sets and returns api secret' do
      assert_nil Lockme.api_secret
      Lockme.api_secret = '270eb10242509cf591067410b425971c6d47339e'
      assert_equal Lockme.api_secret, '270eb10242509cf591067410b425971c6d47339e'
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
