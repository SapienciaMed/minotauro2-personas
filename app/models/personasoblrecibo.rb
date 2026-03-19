class Personasoblrecibo < ApplicationRecord
  belongs_to :personasobligacion
  belongs_to :persona


  def descripcion_persona
    return Persona.find(self.persona_id).autobuscar rescue nil
  end
end
