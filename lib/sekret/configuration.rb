module Sekret
  ##
  # The configuration object
  #
  # @attr mac_secret [String] A random secret that will be used to generate the encryption checksum.
  # @attr private_key [String] A RSA private key in pem format.
  # @attr public_key [String] A RSA public key in pem format.
  Configuration = Struct.new(:mac_secret, :private_key, :public_key)

  ##
  # The config lock
  CONFIG_MUTEX = Mutex.new

  ##
  # Retuns a new config
  #
  # @return [Configuration]
  #
  # @private
  def self.config
    CONFIG_MUTEX.synchronize do
      @config ||= Configuration.new(nil, nil, nil)
    end
  end

  ##
  # Configuration
  def self.configure
    yield config
  end
end
