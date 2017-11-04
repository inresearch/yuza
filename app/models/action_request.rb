class ActionRequest < ApplicationRecord
  self.primary_key = :id
  belongs_to :host

  SIGNIN_REQUEST = 'signin_request'.freeze
  SIGNUP_REQUEST = 'signup_request'.freeze
  REQUESTS = [
    SIGNIN_REQUEST,
    SIGNUP_REQUEST
  ].freeze

  validates_inclusion_of :request, in: REQUESTS

  def init_new_record
    self.id = SecureRandom.hex(10)
  end
end
