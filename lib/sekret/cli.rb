require_relative 'cli/runner'

module Sekret
  ##
  # CLI Interface for Sekret
  #
  # @private
  module CLI
    ##
    # Run the CLI
    #
    # @param args [Array<String>] An array of arguments
    def self.run(args)
      Sekret::CLI::Runner.new(args).call
    end
  end
end
