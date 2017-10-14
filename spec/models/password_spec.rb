require 'rails_helper'

RSpec.describe Password, type: :model do
  subject { described_class.new }

  describe '#password' do
    it 'generates a hash when assigned' do
      expect(subject.cipher).to be_blank
      subject.password = 'Adam'
      expect(subject.cipher).to_not be_blank
    end

    it 'generates a hash when changed even if with same string' do
      subject.password = 'Adam'
      hash1 = subject.cipher
      subject.password = 'Adam'
      hash2 = subject.cipher

      expect(hash1).to_not eq(hash2)
    end
  end # password

  describe '#valid_password?' do
    before { subject.password = 'Password01' }
    it 'returns true if password is valid' do
      expect(subject.valid_password?('Password01')).to eq true
    end

    it 'returns false if password is invalid' do
      expect(subject.valid_password?('Password02')).to eq false
    end
  end
end
