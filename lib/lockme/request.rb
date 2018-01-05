# frozen_string_literal: true

module Lockme
  # API request module providing argument processing and signing
  module SignedRequest
    def self.perform(method, path, data = nil)
      headers = signature(method.upcase, path.gsub(%r{^\/}, ''), data)
      params = {
        body: data,
        headers: headers,
        debug_output: Lockme.logger
      }.delete_if { |k, v| k.nil? || v.nil? }

      resp = Request.send(method.downcase, path, params).parsed_response
      if resp.is_a?(Hash) && resp.has_key?('error')
        raise Lockme::Error, resp['error']
      end
      resp
    rescue JSON::ParserError
      raise Lockme::Error, 'Invalid response from the server'
    end

    def self.signature(*args)
      sha1 = Digest::SHA1.hexdigest([
        *args,
        Lockme.api_secret
      ].compact.join(''))

      {
        'Partner-Key' => Lockme.api_key,
        'Signature'   => sha1
      }
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
