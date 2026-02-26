class Comitesobservacion < ActiveRecord::Base
  belongs_to :comite
  belongs_to :user

  validates_presence_of :observaciones

  def before_save
    self.observaciones = quita_acento(self.observaciones)
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
