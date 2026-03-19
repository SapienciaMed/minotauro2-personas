class Solicitudesobservacion < ActiveRecord::Base
  belongs_to :solicitud
  belongs_to :user
  validates_presence_of :tipo, :observacion
end
