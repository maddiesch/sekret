module Sekret
  ##
  # Custom errors raised by Sekret
  module Errors
    ##
    # The base Error
    #
    # @author Maddie Schipper
    # @since 1.0.0
    class BaseError < StandardError; end

    ##
    # Error raised when a `mac_secret` isn't available for creating the message authenticity
    #
    # @author Maddie Schipper
    # @since 1.0.0
    class MissingMacSecretError < BaseError; end

    ##
    # Error raised if the encryption checksum doesn't match
    #
    # @author Maddie Schipper
    # @since 1.0.0
    class MissmatchedMacError < BaseError; end

    ##
    # Error raised if the payload to be decrypted is invalid
    #
    # @author Maddie Schipper
    # @since 1.0.0
    class InvalidPayloadError < BaseError; end

    ##
    # Error raised if the message header has an unsupported version
    #
    # @author Maddie Schipper
    # @since 1.0.0
    class UnsupportedVersionError < BaseError; end
  end
end
