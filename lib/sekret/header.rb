require 'json'

require_relative 'encoder'

module Sekret
  ##
  # A Payload header
  #
  # @note You should never directly create a Header
  #
  # @author Maddie Schipper
  # @since 1.0.0
  #
  # @private
  class Header
    ##
    # The authenticity token for the header
    # @return [String]
    attr_reader :authenticity

    ##
    # The key used to encrypt the body
    # @return [String]
    attr_reader :key

    ##
    # The initialization vector used to encrypt the body
    # @return [String]
    attr_reader :iv

    ##
    # The encryption version for the body
    # @return [Integer]
    attr_reader :version

    ##
    # The encryption algorithm used to encrypt the body
    # @return [String]
    attr_reader :algorithm

    ##
    # Create a new header
    #
    # @note You should never directly create a Payload
    #
    # @param authenticity (see #authenticity)
    # @param key (see #key)
    # @param eiv (see #iv)
    # @param version (see #version)
    # @param algorithm (see #algorithm)
    def initialize(authenticity, key, eiv, version, algorithm)
      @authenticity = authenticity
      @key = key
      @iv = eiv
      @version = version
      @algorithm = algorithm
    end

    ##
    # @private
    #
    # Create a header from a decrypted hash
    def self.from_decrypted(hash)
      new(
        hash['aut'],
        Encoder.decode(hash['key']),
        Encoder.decode(hash['eiv']),
        hash['ver'],
        hash['alg']
      )
    end

    ##
    # Convert the header into it's hash format
    #
    # @return [Hash]
    def to_h
      {
        aut: authenticity,
        key: Encoder.encode(key),
        eiv: Encoder.encode(iv),
        ver: version,
        alg: algorithm
      }
    end

    ##
    # Convert the header into it's string format
    #
    # @return [String]
    def to_s
      JSON.dump(to_h)
    end
  end
end
