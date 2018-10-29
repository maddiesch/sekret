require 'openssl'

require_relative 'encoder'
require_relative 'body_encryption'
require_relative 'errors'

module Sekret
  ##
  # Handles decrypting a message
  #
  # @author Maddie Schipper
  # @since 1.0.0
  class Decryptor
    ##
    # An intermediate representation of the decrypted message
    #
    # @attr header [String] The encrypted header from the message
    # @attr body [String] The encrypted body of the message
    Payload = Struct.new(:header, :body)

    ##
    # Create a new instance of Decryptor
    #
    # @param public_key [String] The RSA public key used for decrypting the message. (Must be in pem format)
    # @param payload [String] The message payload
    def initialize(public_key, payload)
      @key = OpenSSL::PKey::RSA.new(public_key)
      @raw_payload = payload
    end

    ##
    # Perform the decryption
    #
    # @return [String]
    def call
      payload = create_payload
      header = decrypt_raw_header(payload.header)
      case header.version
      when 1
        Sekret::BodyEncryption.decrypt(header, payload.body)
      else
        raise Sekret::Errors::UnsupportedVersionError, "Can't decrypt body with version: #{header.version}"
      end
    end

    private

    def create_payload
      parts = @raw_payload.split('.')
      if parts.count != 2
        raise Sekret::Errors::InvalidPayloadError, "Expected a header and a body. Found #{parts.count} parts."
      end
      Payload.new(
        Sekret::Encoder.decode(parts[0]),
        Sekret::Encoder.decode(parts[1])
      )
    end

    def decrypt_raw_header(raw)
      raw_header = @key.public_decrypt(raw)
      Sekret::Header.from_decrypted(JSON.parse(raw_header))
    end
  end
end
