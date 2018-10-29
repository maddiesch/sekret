require 'spec_helper'

RSpec.describe Sekret::KeyGenerator do
  describe '.generate_rsa_keys' do
    it { expect { Sekret::KeyGenerator.generate_rsa_keys }.to_not raise_error }

    context 'given valid key size' do
      subject { Sekret::KeyGenerator.generate_rsa_keys(2048) }

      it { expect(subject.public_key).to match /\A-----BEGIN PUBLIC KEY-----(.*)-----END PUBLIC KEY-----\n\z/m }
      it { expect(subject.private_key).to match /\A-----BEGIN RSA PRIVATE KEY-----(.*)-----END RSA PRIVATE KEY-----\n\z/m }
    end
  end
end
