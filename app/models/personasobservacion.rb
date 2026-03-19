class Personasobservacion < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user
  belongs_to :tiposestado
  validates_presence_of :tipo, :observacion, :tiposestado_id, :situacion_econo, :situacion_bene
end


