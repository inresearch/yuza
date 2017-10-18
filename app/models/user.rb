class User < ApplicationRecord
  self.primary_key = :id

  validates_presence_of :id, :name, :email
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  has_many :passwords

  scope :email, -> (email) { where(email: email) }

  def init_new_record
    self.id = SecureRandom.uuid
  end

  def valid_password?(password, app:)
    is_valid = passwords.where(app: app).first&.valid_password?(password)
    is_valid = false if is_valid.nil?
    is_valid
  end

  def init_new_password(attrs)
    passwords.new({
      user_id: id
    }.merge(attrs))
  end
end
