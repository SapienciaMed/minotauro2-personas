class Solicitud < ActiveRecord::Base
  belongs_to :historicostasa
  belongs_to :user
  belongs_to :personasobligacion
  has_many :comitessolicitudes
  has_many :solicitudesobservaciones, :dependent =>:destroy

  validates_presence_of :propuesta,:fecha_solicitud,:ind_economica,:ds_labora,:antecedentes,:concepto_auxiliar,:situacion_bene,:situacion_econo
  validates_presence_of :nombre_empresa,:actividad_economica,:ingresos,:egresos,:direccion_empresa,:telefono_empresa,:if => :in_usa?
  validates_presence_of :nombre_empresads,:if => :in_usb?
  validates_presence_of :fecha_inicio_proceso,:termino,:if => :in_uscongela?
  validate :existesimulacion

  def in_usa?
    self.ind_economica.to_s == "SI"
  end

  def in_usb?
    self.ds_labora.to_s == "SI"
  end

  def in_uscongela?
    self.propuesta.to_s == "CONGELAMIENTO OBLIGACION"
  end

  def existesimulacion
    if self.id.to_i == 0
      if self.propuesta.to_s == "AMPLIACION DE PLAZO" or self.propuesta.to_s == "DISMINUCION DE PLAZO" or self.propuesta.to_s == "REESTRUCTURACION"
        logger.error("self.propuesta.to_s"+self.propuesta.to_s)
        if Planessimulacion.exists?(["personasobligacion_id = #{self.personasobligacion_id}"]) == false
          logger.error("no tiene simulacion")
          errors.add :simulacion, "***** Debe indicar el plazo de la simulacion...."
        elsif self.plazo.to_i > 120
          errors.add :simulacion, "***** El plazo de la simulación no puede ser superior a 120 meses...."
          errors.add :plazo, "***** El plazo de la simulación no puede ser superior a 120 meses...."
        end
      elsif self.propuesta.to_s == "CONGELAMIENTO OBLIGACION"
        if self.fecha_inicio_proceso.to_s != "" and self.fecha_inicio_proceso <= Time.now
          errors.add :fecha_inicio_proceso, "***** No puede existir un congelamiento retroactivo...."
        end
      end
    end
  end

  def before_save
    self.observaciones_comite = quita_acento(self.observaciones_comite)
    self.concepto_juridico = quita_acento(self.concepto_juridico)
    self.antecedentes = quita_acento(self.antecedentes)
    self.concepto_auxiliar = quita_acento(self.concepto_auxiliar)
    self.actividad_economica = quita_acento(self.actividad_economica)
    self.nombre_empresa = quita_acento(self.nombre_empresa)
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
