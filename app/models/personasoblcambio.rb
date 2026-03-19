class Personasoblcambio < ActiveRecord::Base
  belongs_to :personasobligacion
  belongs_to :persona
  belongs_to :user

  validates_presence_of :fecha_matricula, :valor, :plazo, :tasa_final, :observaciones
  validates_numericality_of :valor, :plazo, :tasa_final

end
