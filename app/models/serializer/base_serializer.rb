class Serializer::BaseSerializer
  attr_reader :object

  def initialize(object)
    @object = object
  end

  def success?
    !object.new_record? && object.errors.blank?
  end

  def errors
    object.errors.to_h
  end
  
  def to_h
    {}
  end
end
