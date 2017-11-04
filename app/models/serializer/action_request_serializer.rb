module Serializer
  class ActionRequestSerializer < BaseSerializer
    def to_h
      data = {}
      data[:success] = success?
      data[:errors] = errors
      data[:data] = {
        id: object.id,
        host: object.host.domain,
        request: object.request
      }
      data
    end
  end
end
