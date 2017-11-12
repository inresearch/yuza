class User < ApplicationRecord
  self.primary_key = :id

  validates_presence_of :id, :name, :email
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
  has_many :sessions
  belongs_to :host

  scope :email, -> (email) { where(email: email) }

  def init_new_record
    self.id = SecureRandom.uuid
  end

  include UserPassword
end
