require 'openssl'

module Sekret
  ##
  # Checksum raw data
  #
  # @author Maddie Schipper
  # @since 1.0.0
  #
  # @private
  class Checksum
    class << self
      ##
      # Create a HMAC-SHA256 of a playload
      #
      # @param key [String] The key for the hash
      # @param payload [String] The payload to hash
      #
      # @return [String] The HMAC-SHA256
      def hmac_sha256(key, payload)
        OpenSSL::HMAC.hexdigest('SHA256', key, payload)
      end
    end
  end
end
