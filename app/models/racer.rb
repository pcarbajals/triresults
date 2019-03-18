class Racer
  include Mongoid::Document

  attr :_id

  embeds_one :info, class_name: 'RacerInfo', autobuild: true
  
  before_create do |racer|
    racer.info.id = racer.id
  end
  
end
