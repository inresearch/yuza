class SessionSerializer
  def initialize(session)
    @session = session
  end

  def to_h
    data = {}
    data[:success] = !@session.new_record? && @session.errors.blank?
    data[:errors] = @session.errors.to_h
    data[:data] = {
      id: @session.id,
      code: @session.code,
      app: @session.app,
      expiry_time: @session.expiry_time.to_f,
      user: {
        id: @session.user.id,
        email: @session.user.email
      }
    }
    data
  end
end
