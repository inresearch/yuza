class Host < ApplicationRecord
  self.primary_key = :id
  has_many :action_requests

  validates_presence_of :domain, :name, :color

  def init_new_record
    self.id = SecureRandom.uuid
  end
end
