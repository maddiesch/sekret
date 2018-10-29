require 'spec_helper'

RSpec.describe Sekret::Decryptor do
  let(:message) do
    'El8trHHYTQbwV8ZeOy0oFYIZBk0NBKcYkVyhLIOz3Lj1pBPNKnM1G7maHVUDzMaApYSvVjcYfSj5bZAumkBRdHwKlsBeMq1IZerNgEtplLCsMzB3VVYL3MGbku5ImFks5DTPJePdcDXDYCBXV-aw6byjv-IZKRJfV9Sk_xnM1lW7GIFvWnPJkAIUmrpqJ8Cjuca59Jz1akYGlXSte4Ldfm1qhIVQPsTsS5svoH8qPaPvspldv5v0UmIWxC9bvh1jgaMLaz3It2VmszqGNlMhhUDrr0W40jkq8uvlWAP8pgK1CObiWnUp6WrKy4OIhoxrx1wPRtXp7f8DCaHCtZUW5A==.GZk1CcOvQupsRaoXN-fBFCOKvSFcBrAddGorkT4s08qvjCBKP2kcXyI7fEpm0HWfWty3WobcAdSYjH5qtQD22g=='
  end

  subject { Sekret::Decryptor.new(load_public_key, message) }

  describe '#call' do
    it { expect { subject.call }.to_not raise_error }

    it { expect(JSON.parse(subject.call)['first_name']).to eq 'Maddie' }
    it { expect(JSON.parse(subject.call)['last_name']).to eq 'Schipper' }
    it { expect(JSON.parse(subject.call)['age']).to eq 28 }

    context 'given an invalid payload' do
      it 'with too many parts raises an error' do
        expect { Sekret::Decryptor.new(load_public_key, 'foo.bar.baz').call }.to raise_error Sekret::Errors::InvalidPayloadError do |err|
          expect(err.message).to eq 'Expected a header and a body. Found 3 parts.'
        end
      end

      it 'with too few parts raises an error' do
        expect { Sekret::Decryptor.new(load_public_key, 'foo').call }.to raise_error Sekret::Errors::InvalidPayloadError do |err|
          expect(err.message).to eq 'Expected a header and a body. Found 1 parts.'
        end
      end
    end
  end
end
