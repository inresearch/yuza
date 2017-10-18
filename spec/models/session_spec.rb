require 'rails_helper'

describe Session, type: :model do
  let(:user) { create_user }
  subject { create_session(user) }

  it 'generates id and code upon instantiation' do
    subject = described_class.new
    expect(subject.id).to_not be_blank
    expect(subject.code).to_not be_blank
  end

  context 'when time exceeds validity period' do
    it 'reports as invalid' do
      subject.expiry_time = 1.second.ago
      expect(subject.invalid?).to be true
    end
  end

  context 'when manually revoked' do
    it 'reports as invalid' do
      expect(subject.invalid?).to be false
      subject.revoke!
      expect(subject.invalid?).to be true
    end
  end
end # Session
