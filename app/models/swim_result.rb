class SwimResult < LegResult

  field :pace_100, as: :pace_100, type: Float
  
  def compute_average
    meters = event.meters
    self.pace_100 = meters.nil? ? nil : secs/(meters/100)
  end
end