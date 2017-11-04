class Serializer::UserSerializer
  def initialize(user)
    @user = user
  end

  def to_h
    data = {}
    data[:success] = !@user.new_record? && @user.errors.blank?
    data[:errors] = @user.errors.to_h
    data[:data] = {
      id: @user.id,
      name: @user.name,
      email: @user.email,
      phone: @user.phone,
      created_at: @user.created_at.to_f,
      updated_at: @user.updated_at.to_f
    }
    data
  end
end
