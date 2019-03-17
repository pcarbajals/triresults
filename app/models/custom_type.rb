class CustomType
  def self.demongoize(object)
    case object
    when nil
      nil

    when Hash
      self.new(object)

    when self.klass
      object

    else
      nil
    end
  end

  def self.evolve(object)
    self.mongoize(object)
  end

  def self.mongoize(object)
    case object
    when nil
      nil

    when Hash
      object

    when self.klass
      object.mongoize

    else
      nil
    end
  end
end