class Address

  attr :city, :state, :location

  def initialize(params = {})
    return nil if params.nil?
    
    params.deep_symbolize_keys!

    @city = params[:city]
    @state  = params[:state]
    @location = Point.new(params[:loc])
  end

  def mongoize
    {
      city:  @city,
      state: @state,
      loc:   @location.mongoize
    }
  end

  class << self

    def demongoize(object)
      case object
      when nil
        nil

      when Hash
        Address.new(object)

      when Point
        object

      else
        nil
      end
    end
  
    def evolve(object)
      self.mongoize(object)
    end

    def mongoize(object)
      case object
      when nil
        nil
  
      when Hash
        object
  
      when Address
        object.mongoize
        
      else
        nil
      end
    end
  end
end
