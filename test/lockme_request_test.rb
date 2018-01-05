require 'test_helper'

describe Lockme::SignedRequest do
  before do
    Lockme.api_key = 'asdf'
    Lockme.api_secret = 'qwerty'
  end

  describe "generates valid signature for each request type" do
    describe "GET" do
      it "ignores nil data" do
        headers = Lockme::SignedRequest.signature('GET', 'reservation', nil)
        assert_equal headers["Signature"], "9f37c75740e1a46086d137a29995ab2cf24fd209"
      end
    end

    describe "DELETE" do
      it "ignores nil data" do
        headers = Lockme::SignedRequest.signature('DELETE', 'reservation/1234', nil)
        assert_equal headers["Signature"], "6c362e1402a9921e5fc9ec9dc162d86d94d34361"
      end
    end

    describe "POST" do
      it do
        headers = Lockme::SignedRequest.signature('POST', 'reservation/1234', '{"first_name":"John"}')
        assert_equal headers["Signature"], "f2682fede937698d048190cbe044f768e8aeaa6b"
      end
    end

    describe "PUT" do
      it do
        headers = Lockme::SignedRequest.signature('PUT', 'reservation/1234', '{"first_name":"John"}')
        assert_equal headers["Signature"], "a2a5ea7002258774e8b5cd8e6d19e7ea71e568c2"
      end
    end
  end

  describe "perform" do
    it "ignores nil params" do
      # Kind of ugly but in this spec we want to check how arguments were transformed
      Lockme::Request.stub(:get, ->(_, params) { OpenStruct.new(parsed_response: params) }) do
        params = Lockme::SignedRequest.perform('get', '/test', nil)
        refute params.has_key? :data
      end
    end

    it "raises an error if response includes an error message" do
      Lockme::Request.stub(:get, ->(_, _) { OpenStruct.new(parsed_response: { "error" => "Something went wrong" }) }) do
        assert_raises(Lockme::Error) do
          Lockme::SignedRequest.perform('get', '/test', nil)
        end
      end
    end

    it "raises an error if response is not valid JSON" do
      Lockme::Request.stub(:get, ->(_, _) { raise JSON::ParserError }) do
        assert_raises(Lockme::Error) do
          Lockme::SignedRequest.perform('get', '/test', nil)
        end
      end
    end
  end
end
