class Event
  include Mongoid::Document
  
  field :o, as: :order,    type: Integer
  field :n, as: :name,     type: String
  field :d, as: :distance, type: Float
  field :u, as: :units,    type: String
  
  def meters
    case units
    when 'meters'
      distance
    when 'kilometers'
      distance * 1000
    when 'miles'
      distance * 1609.344
    when 'yards'
      distance * 0.9144
    else 
      nil
    end
    
  end
  
  def miles
    case units
    when 'miles'
      distance
    when 'yards'
      distance * 0.000568182
    when 'meters'
      distance * 0.000621371
    when 'kilometers'
      distance * 0.621371
    else
      nil
    end
  end
end
