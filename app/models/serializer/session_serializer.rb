module Serializer
  class SessionSerializer < BaseSerializer
    def to_h
      data = {}
      data[:success] = success?
      data[:errors] = errors
      data[:data] = {
        id: object.id,
        code: object.code,
        app: object.app,
        expiry_time: object.expiry_time.to_f,
        invalid: object.invalid?,
        user: {
          id: object.user.id,
          email: object.user.email
        },
        created_at: object.created_at.to_f,
        updated_at: object.updated_at.to_f
      }
      data
    end
  end
end
