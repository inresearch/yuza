module Serializer
  class UserSerializer < BaseSerializer
    def to_h
      data = {}
      data[:success] = success?
      data[:errors] = errors
      data[:data] = {
        id: object.id,
        name: object.name,
        email: object.email,
        created_at: object.created_at.to_f,
        updated_at: object.updated_at.to_f
      }
      data
    end
  end
end
