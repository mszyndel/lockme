# frozen_string_literal: true

module Lockme
  # API request module providing argument processing and signing
  module SignedRequest
    def self.perform(method, path, data = nil)
      params = prepare_params(method, path, data)

      resp = Request.send(method.downcase, path, params).parsed_response
      if resp.is_a?(Hash) && resp.has_key?('error')
        raise Lockme::Error, resp['error']
      end
      resp
    rescue JSON::ParserError
      raise Lockme::Error, 'Invalid response from the server'
    end

    def self.signature(*args)
      digest = Digest::SHA1.hexdigest([
        *args,
        Lockme.api_secret
      ].compact.join(''))

      {
        'Partner-Key' => Lockme.api_key,
        'Signature'   => digest
      }
    end

    def self.prepare_params(method, path, data)
      headers = signature(method.upcase, path.gsub(%r{^\/}, ''), data)
      {
        body: data,
        headers: headers,
        debug_output: Lockme.logger
      }.delete_if { |key, val| key.nil? || val.nil? }
    end
  end

  # HTTParty wrapper including some basic configuration
  module Request
    include ::HTTParty

    HEADERS = {
      'User-Agent'    => 'Ruby.Lockme.Api',
      'Accept'        => 'application/json',
      'Content-Type'  => 'application/json'
    }.freeze
    API_VERSION = '1.1'

    base_uri "https://lockme.pl/api/v#{API_VERSION}/"
    headers HEADERS
    format :json

    extend Forwardable
    def_delegators 'self.class', :delete, :get, :post, :put
  end
end
