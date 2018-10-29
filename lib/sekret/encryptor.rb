require_relative 'body_encryption'
require_relative 'encoder'
require_relative 'header'

module Sekret
  ##
  # Encrypt a message
  #
  # @author Maddie Schipper
  # @since 1.0.0
  class Encryptor
    ##
    # The version of the encryption format
    VERSON = 1

    ##
    # Create a new instance of Encryptor
    #
    # @param private_key [String] The RSA private key used for encrypting the message. (Must be in pem format)
    # @param payload [String] The message payload
    #
    # @return [Encryptor]
    def initialize(private_key, payload)
      @key = OpenSSL::PKey::RSA.new(private_key)
      @payload = payload
    end

    ##
    # Perform the encryption
    #
    # @return [String]
    def call
      result = Sekret::BodyEncryption.encrypt(@payload)
      header = create_header(result)
      [
        Sekret::Encoder.encode(encrypt_header(header)),
        Sekret::Encoder.encode(result.body)
      ].join('.')
    end

    private

    def create_header(result)
      Sekret::Header.new(
        result.checksum,
        result.key,
        result.iv,
        VERSON,
        Sekret::BodyEncryption::ALGORITHM
      )
    end

    def encrypt_header(header)
      @key.private_encrypt(header.to_s)
    end
  end
end
