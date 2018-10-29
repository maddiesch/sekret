require 'spec_helper'

RSpec.describe Sekret::Encryptor do
  let(:payload) do
    JSON.dump(
      first_name: 'Maddie',
      last_name: 'Schipper',
      age: 28
    )
  end

  subject { Sekret::Encryptor.new(load_private_key, payload) }

  describe '#call' do
    it { expect { subject.call }.to_not raise_error }
  end
end
