class Address < CustomType

  attr_accessor :city, :state, :location

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

  def self.klass
    Address    
  end
end
