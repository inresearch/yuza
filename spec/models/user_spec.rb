require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new }
  
  describe '#id' do
    it 'generates anew if new record' do
      expect(subject.id).to_not be_blank
      expect(User.new.id).to_not eq subject.id
    end

    it 'does not replace id when not new record' do
      user = create_user
      expect(user.id).to_not be_blank
      expect(User.find(user.id).id).to eq user.id
    end
  end # id

  describe '#email' do
    it 'rejects invalid email' do
      subject.email = '@'
      subject.valid?
      expect(subject.errors).to include(:email)

      subject.email = 'x@'
      subject.valid?
      expect(subject.errors).to include(:email)

      subject.email = 'x@x'
      subject.valid?
      expect(subject.errors).to include(:email)

      subject.email = '1'
      subject.valid?
      expect(subject.errors).to include(:email)
    end

    it 'accepts valid email' do
      subject.email = 'x@x.com'
      subject.valid?
      expect(subject.errors).to_not include(:email)
    end
  end # email

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
  end # valid_password?
end
