class Session < ApplicationRecord
  self.primary_key = :id

  validates_presence_of :user_id, :code, :app, :expiry_time
  validates :code, length: { maximum: 100 }
  belongs_to :user

  def init_new_record
    self.id = SecureRandom.uuid
    self.code = SecureRandom.hex(50)
    self.revoked = false
  end

  def invalid?
    revoked? || (Time.current > expiry_time)
  end

  def invalidate!
    self.revoked = true
    self.save!
  end
end
