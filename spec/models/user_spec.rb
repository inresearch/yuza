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
end
