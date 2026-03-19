class Personascontrol < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user

  validates_presence_of :tipo_atencion, :observacion

end
