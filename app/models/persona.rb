
class Persona < ApplicationRecord
  has_many :personasdirecciones, :dependent =>:destroy
  has_many :personastelefonos, :dependent =>:destroy
  has_many :personascodeudores, :dependent =>:destroy
  has_many :personasimagenes, :dependent =>:destroy
  has_many :personasobligaciones, :dependent =>:destroy
  has_many :personasobservaciones, :dependent =>:destroy
  has_many :personasacademicos, :dependent =>:destroy
  has_many :personasliquidaciones, :dependent =>:destroy
  has_many :personasgiros, :dependent =>:destroy
  has_many :personasalistamientos, :dependent =>:destroy
  has_many :personasprocesos, :dependent =>:destroy
  has_many :controles, :dependent =>:destroy
  has_many :personascontroles, :dependent =>:destroy
  has_many :personascorreos, :dependent =>:destroy
  has_many :personasoblcambios, :dependent =>:destroy

  validates_presence_of :primer_nombre, :primer_apellido, :identificacion
  validates_numericality_of :identificacion
  validates_uniqueness_of :identificacion

  def perapellidos
    "#{primer_apellido} #{segundo_apellido}" rescue nil
  end

  def pernombres
    "#{primer_nombre} #{segundo_nombre}" rescue nil
  end


  def self.replacespace(campo)
    campo.gsub(" ", "%%").gsub(" ", "%%").gsub(" ", "%%").gsub(" ", "%%")
  end

  def self.search(identificacion, nroobligacion)
    cadena = []
    cadena << "(upper(autobuscar) like '%%#{replacespace(identificacion.to_s.upcase)}%%' or id in (select distinct persona_id from personascodeudores where upper(autobuscar) like '%%#{replacespace(identificacion.to_s.upcase)}%%'))" if identificacion.to_s != ""
    cadena << "id in (select persona_id from personasobligaciones where nro_obligacion = '#{nroobligacion.strip}')" if nroobligacion.to_s != ""
    if cadena.size.positive?
      sqlDatos = ""
      sqlDatos << " #{cadena.join(" and ")}"
      where("#{sqlDatos}").order('created_at desc')
    else
      where("DATE(created_at) = ?", Date.today).order(created_at: :asc)
    end
  end


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

  def perdireccion
    personasdireccion = Personasdireccion.find(:first, :conditions=>["persona_id = #{self.id}"], :order=>"updated_at desc")
    if personasdireccion
      return personasdireccion.direccion rescue nil
    end
  end

  def perciudad
    personasdireccion = Personasdireccion.find(:first, :conditions=>["persona_id = #{self.id}"], :order=>"updated_at desc")
    if personasdireccion
      return personasdireccion.ciudad rescue nil
    end
  end

  def pertelefono
    personastelefono = Personastelefono.find(:first, :conditions=>["persona_id = #{self.id}"], :order=>"updated_at desc")
    if personastelefono
      return personastelefono.telefono rescue nil
    end
  end

  def radicadon
    if self.radicado.to_s == ""
      if self.radicado1.to_s == ""
        if self.radicado2.to_s == ""
          return 'N'
        else
          return self.radicado2.to_s
        end
      else
        return self.radicado1.to_s
      end
    else
      return self.radicado.to_s
    end
  end

  def radicado2n
    if self.radicado_solidario.to_s == ""
      if self.radicado1_solidario.to_s == ""
        if self.radicado2_solidario.to_s == ""
          return 'N'
        else
          return self.radicado2_solidario.to_s
        end
      else
        return self.radicado1_solidario.to_s
      end
    else
      return self.radicado_solidario.to_s
    end
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'btn btn-danger'
    else
      return 'btn btn-default'
    end
  end  

  def controlbloqueo
    if self.controles.exists?(["tiposcontrol_id = 10005"]) == true
      return false
    else
      return true
    end
  end
end