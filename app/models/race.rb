class Race
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated
  
  field :n,    as: :name,     type: String
  field :date, as: :date,     type: Date
  field :loc,  as: :location, type: Address
  
  embeds_many :events, as: :parent, order: [:order.asc]
  
  scope :upcoming, -> { where(:date.gt  => Date.today) }
  scope :past,     -> { where(:date.lte => Date.today) }
end
