require 'erb'
require 'pathname'

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
        when 'help'
          print_help
        when 'version'
          print_version
        else
          raise "Unknown Command #{command}. Try `sekret help`"
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

      def print_help
        path = ::Pathname.new(__dir__).join('help.txt.erb')
        content = File.read(path)
        template = ERB.new(content)
        STDOUT.puts(template.result)
      end

      def print_version
        STDOUT.puts(Sekret::VERSION)
      end
    end
  end
end
