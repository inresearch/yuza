class Password < ApplicationRecord
  validates_presence_of :user_id, :app, :cipher

  APP_LIST = [
    'pageok'
  ].freeze

  attr_accessor :password
  validates :password, length: { minimum: 8 }, if: -> { new_record? || password }
  validates_inclusion_of :app, in: APP_LIST

  scope :app, -> (app) { where(app: app) }

  def init_new_record
    self.id = SecureRandom.uuid
  end

  def valid_password?(password)
    hashed_password = BCrypt::Password.new(cipher)
    hashed_password == password
  end

  def password=(new_password)
    password = BCrypt::Password.create(new_password)
    self.cipher = password.to_s
    @password = new_password
  end
end
