class Personasimagen < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user

  validates_presence_of :descripcion, :tipo
  has_attached_file :persona,
                    styles: { medium: '500x500!', thumb: '200x200!', dato: '600x600!', dato2: '800x800!' },
                    whiny: false
  validates_attachment_presence :persona, :message => 'Debe seleccionar un archivo valido!!'


  validates_attachment_content_type :persona, content_type: /\A*\/.*\Z/
  #validates_attachment_content_type :persona, content_type: ["application/x-ole-storage","image/tiff","image/tif", "image/jpg", "application/vnd.ms-outlook; charset=binary","application/x-ole-storage","image/jpeg", "image/png", "image/gif", "application/pdf", "application/vnd.ms-excel","application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "application/vnd.ms-powerpoint", "application/vnd.openxmlformats-officedocument.presentationml.presentation"]
  validates_attachment_size :persona, :less_than => 30000.kilobytes, :message => 'El tamaño del archivo no puede ser superior a 30 Megabytes!!!'

  def after_create
    if self.tipo.to_s == 'NOTIFICACIONES PLANES DE AMORTIZACION'
      personasobservacion = Personasobservacion.new
      personasobservacion.persona_id = self.persona_id
      personasobservacion.user_id = 10002
      personasobservacion.tipo = 'CORREO FISICO'
      personasobservacion.tiposestado_id = 2
      personasobservacion.observacion = 'SE ESTRUCTURA PLAN DE AMORTIZACION DE ACUERDO CON NORMATIVIDAD. SE REMITE COMUNICACION FORMAL A LA DIRECCION DEL '+self.descripcion.gsub("CARTA ","").to_s
      if Personasobservacion.where(["created_at < to_date('#{self.created_at.to_s}','dd/mm/yyyy') and persona_id = #{self.persona_id} and situacion_econo is not null"]).exists?
          objeto = Personasobservacion.where(["created_at < to_date('#{self.created_at.to_s}','dd/mm/yyyy') and persona_id = #{self.persona_id} and situacion_econo is not null"]).last
          personasobservacion.situacion_econo = objeto.situacion_econo
          personasobservacion.situacion_bene = objeto.situacion_bene
      else
          personasobservacion.situacion_econo = 'SIN DATO'
          personasobservacion.situacion_bene = 'SIN DATO'
      end
      personasobservacion.created_at = self.created_at
      personasobservacion.updated_at = self.updated_at
      personasobservacion.save
    elsif self.tipo.to_s == 'FACTURACION'
      personasobservacion = Personasobservacion.new
      personasobservacion.persona_id = self.persona_id
      personasobservacion.user_id = 10002
      personasobservacion.tipo = 'CORREO FISICO'
      if Personasobservacion.exists?(["created_at < to_date('#{self.created_at.to_s}','dd/mm/yyyy') and persona_id = #{self.persona_id} and situacion_econo is not null"])
          objeto = Personasobservacion.where(["created_at < to_date('#{self.created_at.to_s}','dd/mm/yyyy') and persona_id = #{self.persona_id} and situacion_econo is not null"]).last
          personasobservacion.tiposestado_id = 13
          personasobservacion.situacion_econo = objeto.situacion_econo
          personasobservacion.situacion_bene = objeto.situacion_bene
      else
          personasobservacion.tiposestado_id = 13
          personasobservacion.situacion_econo = 'SIN DATO'
          personasobservacion.situacion_bene = 'SIN DATO'
      end
      personasobservacion.observacion = 'SE ESTRUCTURA FACTURA DEL DEUDOR Y SE REMITE POR CORREO FISICO PARA EL MES Y ANO ('+self.descripcion.gsub("FACTURACION ","").to_s+'). SE CARGA FACTURA DIGITAL DE SOPORTE AL MINOTAURO'
      personasobservacion.created_at = self.created_at
      personasobservacion.updated_at = self.updated_at
      personasobservacion.save
    end
  end
end
