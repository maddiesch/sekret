module Sekret
  module CLI
    ##
    # The class that handle the CLI
    #
    # @author Maddie Schipper
    # @since 1.0.0
    #
    # @private
    class Runner
      ##
      # The arguments left after parsing options
      #
      # @return [Array<String>]
      attr_reader :args

      ##
      # Create a new runner instance
      #
      # @param args [Array<String>] The CLI arguments
      def initialize(args)
        @args = args
      end

      ##
      # Perform the CLI call
      def call
        command = args.shift
        case command
        when 'generate-keys'
          perform_generate_keys
        else
          raise "Unknown Command #{command}"
        end
      end

      private

      def perform_generate_keys
        keys = Sekret::KeyGenerator.generate_rsa_keys
        puts <<~EOF
          Generated new keys:
           Private Key
           #{keys.private_key}
           Public Key
           #{keys.public_key}
        EOF
      end
    end
  end
end
