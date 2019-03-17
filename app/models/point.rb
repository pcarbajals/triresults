class Point < CustomType

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

  def self.klass
    Point
  end
end
