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
    if event && secs
      compute_average
    end
  end
  
  def secs= value
    self[:secs] = value
    calc_ave
  end
  
  def compute_average
    # this is where subclasses compute their average to be used in calc_ave
  end
end