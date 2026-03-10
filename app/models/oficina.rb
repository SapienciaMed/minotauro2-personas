class Oficina < ActiveRecord::Base
  has_many :personasalisbienes
  has_many :municipios

  def munic
    mu = Municipio.find(self.municipio_id).muni
    return mu.to_s + ' - ' + self.descripcion.to_s rescue nil
  end
end
