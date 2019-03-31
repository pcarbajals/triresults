class LegResult
  include Mongoid::Document
  
  field :event,           type: Event
  field :secs, as: :secs, type: Float
  
  embedded_in :entrant
  embeds_one  :event
  
  validates_presence_of :event

  after_initialize do |doc|
    calc_ave
  end

  def calc_ave
    #subclasses will calc event-specific ave
  end
  
  def secs= value
    self[:secs] = value
    calc_ave
  end
end