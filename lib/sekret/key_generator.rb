require 'openssl'

module Sekret
  ##
  # Create new keys for encryption
  #
  # @author Maddie Schipper
  # @since 1.0.0
  class KeyGenerator
    ##
    # A new key object
    #
    # @attr public_key [String] Public key in pem format.
    # @attr private_key [String] Private key in pem format.
    Key = Struct.new(:public_key, :private_key)

    class << self
      ##
      # Generate a new RSA public/private key pair
      #
      # @param size [Integer] size of the RSA key to generate
      #   (defaults to 2048)
      #
      # @return [Key] the new public & private keys.
      #
      # @note The returned key is read-only
      def generate_rsa_keys(size = 2048)
        rsa_key = OpenSSL::PKey::RSA.new(size)
        Key.new(
          rsa_key.public_key.to_pem,
          rsa_key.to_pem
        ).freeze
      end
    end
  end
end
