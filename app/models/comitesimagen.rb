class Comitesimagen < ActiveRecord::Base
  belongs_to :comite
  belongs_to :user

  validates_presence_of :descripcion
  has_attached_file :comite
  validates_attachment_presence :comite, :message => 'Debe seleccionar un archivo valido!!'

  def before_save
    self.descripcion = quita_acento(self.descripcion)
  end


  def quita_acento(dato)
    valor = dato.gsub('Á','A') rescue nil
    valor = valor.gsub('É','E') rescue nil
    valor = valor.gsub('Í','I') rescue nil
    valor = valor.gsub('Ó','O') rescue nil
    valor = valor.gsub('Ú','U') rescue nil
    valor = valor.gsub('Ñ','N') rescue nil
    return valor.to_s
  end


end

