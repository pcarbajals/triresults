class RunResult < LegResult

  field :mmile, as: :minute_mile, type: Float
  
  def compute_average
    miles = event.miles
    self.minute_mile = miles.nil? ? nil : (secs/60)/miles
  end
end