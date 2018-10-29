require 'sekret/configuration'
require 'sekret/decryptor'
require 'sekret/encryptor'
require 'sekret/errors'
require 'sekret/key_generator'
require 'sekret/version'

##
# Used for encrypting/decrypting data
module Sekret
  ##
  # Encrypt the passed payload
  #
  # @param payload [String] The plaintext to encrypt
  #
  # @return [String] The encrypted payload
  def self.encrypt(payload)
    Sekret::Encryptor.new(Sekret.config.private_key, payload).call
  end

  ##
  # Decrypt the passed payload
  #
  # @param message [String] the encrypted message to decrypt
  #
  # @return [String] The un-encrypted payload
  def self.decrypt(message)
    Sekret::Decryptor.new(Sekret.config.public_key, message).call
  end
end
