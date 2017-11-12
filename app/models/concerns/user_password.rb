module UserPassword
  extend ActiveSupport::Concern

  included do
    attr_reader :password
    validates :password, length: { minimum: 8 }, if: -> { new_record? || password }
  end

  def valid_password?(password)
    hashed_password = BCrypt::Password.new(password_cipher)
    hashed_password == password
  end

  def password=(new_password)
    password = BCrypt::Password.create(new_password)
    self.password_cipher = password.to_s
    @password = new_password
  end
end
