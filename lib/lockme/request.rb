module Lockme
  module Request
    def self.perform(method, path, data = nil)
      headers = signature(method, path, data)
      params = {
        body: data,
        headers: headers,
        debug_output: Lockme.logger
      }.compact
      resp = SignedRequest.send(method.downcase, path, params).parsed_response
      if resp.is_a?(Hash) && resp['error']
        raise Lockme::Error.new(resp['error'])
      end
      resp
    rescue JSON::ParserError
      raise Lockme::Error.new('Invalid response from the server')
    end

    def self.signature(method, path, data)
      digest = Digest::SHA1.hexdigest([
        method.upcase,
        path.gsub(/^\//, ''),
        data || '[]',
        Lockme.api_secret
      ].join(''))

      {
        'Partner-Key' => Lockme.api_key,
        'Signature'   => digest
      }
    end

    class << self
      private :signature
    end
  end

  module SignedRequest
    include ::HTTParty

    HEADERS = {
      'User-Agent'    => 'Ruby.Lockme.Api',
      'Accept'        => 'application/json',
      'Content-Type'  => 'application/json'
    }
    API_VERSION = '1.0'

    base_uri "https://lockme.pl/api/v#{API_VERSION}/"
    headers HEADERS
    format :json

    extend Forwardable
    def_delegators 'self.class', :delete, :get, :post, :put
  end
  private_constant :SignedRequest
end
