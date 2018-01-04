module Lockme
  module Configuration
    def api_key
      defined?(@api_key) ? @api_key : nil
    end

    def api_key=(key)
      @api_key = key
    end

    def api_secret
      defined?(@api_secret) ? @api_secret : nil
    end

    def api_secret=(key)
      @api_secret = key
    end

    def logger
      defined?(@logger) ? @logger : nil
    end

    def logger=(logger)
      @logger = logger
    end
  end
  private_constant :Configuration
end
