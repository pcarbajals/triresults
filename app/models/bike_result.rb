class BikeResult < LegResult

  field :mph, as: :mph, type: Float
  
  def compute_average
    miles = event.miles
    self.mph = miles.nil? ? nil : miles*3600/secs
  end
end