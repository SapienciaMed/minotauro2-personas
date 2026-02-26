class Desembolsospersona < ActiveRecord::Base

	has_many :desembolsos
	has_many :desembolsoscreditos
	has_many :desembolsosrelaciones
	
  #def self.search (proyecto,nro_registro,encuesta,cobama,clasereasentamiento,identificacion,inmueble,ficticia,page,perpage)
  def self.search (identificacion,nombre,page,perpage)
    if identificacion.to_s == "" and nombre.to_s == ""
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
      if nombre != ""
        s = nombre.upcase
        if cadena != ""
          cadena = cadena + " and nombre_completo like '%%#{s.to_s.strip}%%'"
        else
          cadena = cadena + " nombre_completo like '%%#{s.to_s.strip}%%'"
        end
      end
      #logger.error("Cadenaaaaa..."+cadena.to_s)
      paginate :per_page => perpage, :page => page, :conditions => [cadena], :order=>'created_at desc'
    end
  end

=begin  def searchinforme (fondo,convocatoria,ies,operador_financiero,formato)
    cadena = ""
    if fondo != ""
      if cadena != ""
        cadena = cadena + ' and fondo  = '+ "'#{fondo.strip}'"
      else
        cadena = cadena + ' fondo  = '+ "'#{fondo.strip}'"
      end
    end
    if convocatoria != ""
      if cadena != ""
        cadena = cadena + ' and convocatoria  = '+ "'#{convocatoria.strip}'"
      else
        cadena = cadena + ' convocatoria  = '+ "'#{convocatoria.strip}'"
      end
    end
    if ies != ""
      if cadena != ""
        cadena = cadena + ' and ies  = '+ "'#{ies.strip}'"
      else
        cadena = cadena + ' ies  = '+ "'#{ies.strip}'"
      end
    end
    if operador_financiero != ""
      if cadena != ""
        cadena = cadena + ' and operador_financiero  = '+ "'#{operador_financiero.strip}'"
      else
        cadena = cadena + ' operador_financiero  = '+ "'#{operador_financiero.strip}'"
      end
    end
    return cadena
  end
=end

end
