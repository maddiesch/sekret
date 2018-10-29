module Loader
  def load_public_key
    path = Pathname.new(__dir__).join('public.pem')
    File.read(path)
  end

  def load_private_key
    path = Pathname.new(__dir__).join('private.pem')
    File.read(path)
  end
end

RSpec.configure do |config|
  config.include(Loader)
end
