require 'base64'

module Sekret
  ##
  # Encode data objects into URL safe base64
  #
  # @author Maddie Schipper
  # @since 1.0.0
  #
  # @private
  class Encoder
    class << self
      ##
      # Encode the value into URL safe base64
      #
      # @param value [String] the data to encode
      #
      # @return [String] A URL safe base64 encoded string
      def encode(value)
        Base64.urlsafe_encode64(value)
      end

      ##
      # Decode the URL safe base64 string into it's raw data
      #
      # @param value [String] URL safe base64 string
      #
      # @return [String] A decoded data string
      def decode(value)
        ##
        # Decode the URL safe base64 into it's raw format
        Base64.urlsafe_decode64(value)
      end
    end
  end
end
