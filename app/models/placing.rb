class Placing < CustomType

  attr :name, :place

  def initialize(params = {})
    return nil if params.nil?

    params.deep_symbolize_keys!

    # handles both GeoJSON Point format or {:lat, :lng}
    @name  = params[:name]
    @place = params[:place]
  end

  def mongoize
    {
        name:  @name,
        place: @place
    }
  end

  def self.klass
    Placing
  end

end
