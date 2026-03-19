class Personasdireccion < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user
  belongs_to :municipio
  validates_presence_of :direccion, :municipio_id, :barrio, :tipo

  def estadoa
    if self.estado == 'ACTIVO'
      return 'tabac'
    elsif self.estado == 'INACTIVO'
      return 'tabin'
    elsif self.estado == 'TERCERO'
      return 'tabter'
    end
  end
end

