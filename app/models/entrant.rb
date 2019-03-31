class Entrant
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :bib,    as: :bib,     type: Integer
  field :secs,   as: :secs,    type: Float
  field :o,      as: :overall, type: Placing
  field :gender, as: :gender,  type: Placing
  field :group,  as: :group,   type: Placing

  store_in collection: :results
  
  embeds_many :results, class_name: 'LegResult', order: [:'event.o'.asc], after_add: :update_total
  embeds_one  :race,    class_name: 'RaceRef'
  embeds_one  :racer,   class_name: 'RacerInfo', as: :parent, autobuild: true

  def the_race
    race.race
  end

  def update_total(result)
    self.secs = results.map { |a_result| a_result.secs }.reduce(:+)
  end
end