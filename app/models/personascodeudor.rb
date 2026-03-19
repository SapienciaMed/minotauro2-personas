class Personascodeudor < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user

  def before_save
    self.primer_nombre = quita_acento(self.primer_nombre)
    self.segundo_nombre = quita_acento(self.segundo_nombre)
    self.primer_apellido = quita_acento(self.primer_apellido)
    self.segundo_apellido = quita_acento(self.segundo_apellido)
    nom =  ""
    if self.identificacion.nil? == false
      nom = self.identificacion.to_s
    end
    if self.primer_nombre.nil? == false
      nom = nom + ' ' + self.primer_nombre.to_s
    end
    if self.segundo_nombre.nil? == false
      nom = nom + ' ' + self.segundo_nombre.to_s
    end
    if self.primer_apellido.nil? == false
      nom = nom + ' ' + self.primer_apellido.to_s
    end
    if self.segundo_apellido.nil? == false
      nom = nom + ' ' + self.segundo_apellido.to_s
    end
    self.autobuscar = nom
  end

  def telefonos
    return self.telefono_oficina rescue nil + ' ' + self.telefono_casa rescue nil + ' ' + self.celular rescue nil + ' ' + self.celular_secundario rescue nil
  end

  def nombres
    nom =  ""
    if self.primer_nombre.nil? == false
      nom = nom + ' ' + self.primer_nombre.to_s
    end
    if self.segundo_nombre.nil? == false
      nom = nom + ' ' + self.segundo_nombre.to_s
    end
    if self.primer_apellido.nil? == false
      nom = nom + ' ' + self.primer_apellido.to_s
    end
    if self.segundo_apellido.nil? == false
      nom = nom + ' ' + self.segundo_apellido.to_s
    end
    return nom
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
