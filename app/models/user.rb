class User < ApplicationRecord
  self.primary_key = :id

  attr_accessor :password
  validates_presence_of :id, :name, :email, :password_hash
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def init_new_record
    self.id = SecureRandom.uuid
  end

  def password
    return @password if @password
    @password = BCrypt::Password.new(password_hash) if password_hash
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password.to_s
  end
end
