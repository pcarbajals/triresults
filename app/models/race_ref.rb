class RaceRef
  include Mongoid::Document

  field :n,    as: :name, type: String
  field :date, as: :date, type: Date

  belongs_to :race, foreign_key: '_id'
  
  embedded_in :entrant
end