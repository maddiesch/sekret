require 'simplecov'

SimpleCov.start do
  add_filter '/spec'
  add_filter '/vendor'
end

require 'bundler/setup'
require 'pry'
require 'sekret'

Dir.glob(Pathname.new(__dir__).join('support', '**', '*.rb')).each { |f| require f }

Sekret.configure do |config|
  config.mac_secret = 'Super Sekret Passwordz'
  config.public_key = File.read(Pathname.new(__dir__).join('support', 'keys', 'public.pem'))
  config.private_key = File.read(Pathname.new(__dir__).join('support', 'keys', 'private.pem'))
end

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
