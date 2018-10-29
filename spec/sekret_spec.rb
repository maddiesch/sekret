require 'spec_helper'

RSpec.describe Sekret do
  it 'has a version number' do
    expect(Sekret::VERSION).not_to be nil
  end

  describe 'sanity' do
    it { expect(load_public_key).to_not be_nil }
    it { expect(load_private_key).to_not be_nil }
  end

  describe '.encrypt' do
    it { expect { Sekret.encrypt('foo') }.to_not raise_error }
  end

  describe '.decrypt' do
    let(:message) { 'CpMcLMfS8cnMG7VfzlywnIykH-ONyDi3pAhOLyhzVo2kuNFX-DvSzMG9wX5VQGwMYnKeoUhBHKqai6PZI1iYvs9VS8TxCY8rGlhNK5Gt1gUb9eB1yW1nmJEwWr2abJEjyADGb9KQR68zVFwM4s3d3WkijmzpCxEgBVkcR_nS7lIENMNVUGUV4gp8cUauPB10qP8PVBCRRSCAicZGSgS2Ap_apJO8wNpBt5u1qjKWD6MLPE84OSIFIvWB3ICgXBXtqKKu0sdgLTofI2X6pwxBWv6I0fDFzb6AaB0Zj1QBwQL_-ww-u105d7aP5bTfCzLocfuzTYjttg9tYeMcwTTT9w==.dq6sI1yHGOZWeXFlP-ru-Q==' }

    it { expect { Sekret.decrypt(message) }.to_not raise_error }

    it { expect(Sekret.decrypt(message)).to eq 'foo' }
  end
end
