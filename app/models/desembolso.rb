class Desembolso < ActiveRecord::Base
	belongs_to :desembolsospersona

  #def self.search (proyecto,nro_registro,encuesta,cobama,clasereasentamiento,identificacion,inmueble,ficticia,page,perpage)
  def self.search (identificacion,page,perpage)
    if identificacion.to_s == ""
      paginate :per_page => 10, :page => page, :conditions => ["id = '-1'"]
    else
      cadena = ""
      if identificacion != ""
        if cadena != ""
          cadena = cadena + " and documento = '#{identificacion.strip}' or documento_anterior = '#{identificacion.strip}'"
        else
          cadena = cadena + " documento = '#{identificacion.strip}' or documento_anterior = '#{identificacion.strip}'"
        end
      end
      #logger.error("Cadenaaaaa..."+cadena.to_s)
      paginate :per_page => perpage, :page => page, :conditions => [cadena], :order=>'created_at desc'
    end
  end
end
