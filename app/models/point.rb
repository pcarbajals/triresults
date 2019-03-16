class Point

  attr :longitude, :latitude

  def initialize(params = {})
    return nil if params.nil?
    
    params.deep_symbolize_keys!

    # handles both GeoJSON Point format or {:lat, :lng}
    @longitude = params[:lng].nil? ? params[:coordinates][0] : params[:lng]
    @latitude  = params[:lat].nil? ? params[:coordinates][1] : params[:lat]
  end

  def mongoize
    {
        type: 'Point',
        coordinates: [@longitude, @latitude]
    }
  end

  class << self

    def demongoize(object)
      case object
      when nil
        nil

      when Hash
        Point.new(object)

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
  
      when Point
        object.mongoize
        
      else
        nil
      end
    end
  end
end
