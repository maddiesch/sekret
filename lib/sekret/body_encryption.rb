require 'openssl'

require_relative 'checksum'
require_relative 'configuration'
require_relative 'errors'

module Sekret
  ##
  # Performs the AES encryption on the message body
  #
  # @author Maddie Schipper
  # @since 1.0.0
  #
  # @private
  class BodyEncryption
    ##
    # The algorithm used for encryption/decryption
    ALGORITHM = 'AES-256-CBC'.freeze

    class << self
      ##
      # The result of the encryption
      #
      # @attr key [String] The random key used for encryption
      # @attr iv [String] The random iv used for encryption
      # @attr checksum [String] The HMAC-SHA256 of the encrypted body
      # @attr body [String] The encrypted body
      Result = Struct.new(:key, :iv, :checksum, :body)

      ##
      # Encrypt a payload using a random key and iv
      #
      # @param plaintext [String] The payload to encrypt
      #
      # @return [Result]
      def encrypt(plaintext)
        key = OpenSSL::Cipher.new(ALGORITHM).random_key
        iv = OpenSSL::Cipher.new(ALGORITHM).random_iv
        aes = OpenSSL::Cipher.new(ALGORITHM)
        aes.encrypt
        aes.key = key
        aes.iv = iv
        cipher = aes.update(plaintext)
        cipher << aes.final
        digest = generate_digest(cipher)
        Result.new(key, iv, digest, cipher)
      end

      ##
      # Decrypt the payload
      #
      # @param header [Header] The header that contains the key, iv, & checksum
      # @param encrypted [String] The encrypted content
      #
      # @return [String] The un-encrypted message
      def decrypt(header, encrypted)
        validate_checksum!(header.authenticity, encrypted)
        aes = OpenSSL::Cipher.new(ALGORITHM)
        aes.decrypt
        aes.key = header.key
        aes.iv = header.iv
        plaintext = aes.update(encrypted)
        plaintext << aes.final
        plaintext
      end

      private

      def generate_digest(body)
        return nil if Sekret.config.mac_secret.nil?
        Checksum.hmac_sha256(Sekret.config.mac_secret, body)
      end

      def validate_checksum!(checksum, body)
        return if checksum.nil?
        if Sekret.config.mac_secret.nil?
          raise Sekret::Errors::MissingMacSecretError,
                'The encrypted message contains an authenticity. But Sekret doesn\'t have a mac_secret'
        end
        digest = Checksum.hmac_sha256(Sekret.config.mac_secret, body)
        if digest != checksum
          raise Sekret::Errors::MissmatchedMacError, 'The message authenticity doesn\'t match.'
        end
      end
    end
  end
end
