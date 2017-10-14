class User < ApplicationRecord
  self.primary_key = :id

  attr_accessor :password
  validates_presence_of :id, :name, :email, :password_hash
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  validates :password, length: { minimum: 8 }, if: -> { new_record? || password }

  def init_new_record
    self.id = SecureRandom.uuid
  end

  def valid_password?(password)
    hashed_password = BCrypt::Password.new(password_hash)
    hashed_password == password
  end

  def password=(new_password)
    password = BCrypt::Password.create(new_password)
    self.password_hash = password.to_s
    @password = new_password
  end
end
