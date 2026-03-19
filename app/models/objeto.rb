class Objeto < ApplicationRecord
  audited

  validates_presence_of :descripcion, :descripcion_ampliada

  after_save :despuesdeguardar

  def descripcionamp
  	 return self.descripcion_ampliada.to_s + ' ('+self.descripcion.to_s+')'
  end

  def despuesdeguardar
    @adminusers = User.where(geintac: 'S')
    @adminusers.each do |au|
      objetouser = Userspermiso.new(user_id: au.id, objeto_id: self.id, actualiza: 'S', crea: 'S', elimina: 'S')
      objetouser.save
    end
  end

  def fechacuotainicial(personasobligacion_id)
    begin
      Planesobligacion.where(personasobligacion_id: personasobligacion_id).first.fecha_vence.strftime()
    rescue
      ""
    end
  end
end
