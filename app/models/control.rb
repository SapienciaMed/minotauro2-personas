class Control < ActiveRecord::Base
  belongs_to :persona
  belongs_to :tiposcontrol
  belongs_to :user

  validates_presence_of :tiposcontrol_id, :fecha
  validates_presence_of :resolucion, :repone, :valor_final, :if => :in_rep?
  validates_numericality_of :resolucion, :valor_final, :if => :in_rep?

  def in_rep?
    self.tiposcontrol_id == 10003
  end

  def before_create
  	if self.fecha.to_s != ""
  		#tiposcontrol = Tiposcontrol.find(self.tiposcontrol.).dias
      if self.tiposcontrol.dias_clase.to_s == 'CALENDARIO'
  	  	objetos = Objeto.find_by_sql(["select to_date('#{self.fecha.to_s}','dd/mm/yyyy') + #{self.tiposcontrol.dias.to_i} fch from dual"])
  	    objetos.each do |objeto|
  	    	self.fecha_vencimiento = objeto.fch.to_date
  	    end
      else
        objetos = Objeto.find_by_sql(["select fch_limite(to_date('#{self.fecha.to_s}','dd/mm/yyyy'), #{self.tiposcontrol.dias.to_i}) fch from dual"])
        objetos.each do |objeto|
          self.fecha_vencimiento = objeto.fch.to_date
        end        
      end
	  end
  end

  def self.search(search, page)
    if search.to_s == ""
      paginate :per_page => 10, :page => page, :conditions => ["tiposcontrol_id = 10004 and fecha_vencimiento >= trunc(sysdate) 
                              and persona_id not in (select distinct persona_id from controles where tiposcontrol_id = 10005 and persona_id not in (select id from personas where resolucion_2017 = '127'))"]
    else
      s = search.upcase
      if Persona.exists?(["resolucion_2017 = '127' and autobuscar like '%%#{s.to_s.strip}%%'"]) == true
        paginate :per_page => 10,
                 :page => page,
                 :conditions => ["tiposcontrol_id = 10004 and fecha_vencimiento >= trunc(sysdate)
                                  and persona_id in (select id from personas where resolucion_2017 = '127' and autobuscar like '%%#{s.to_s.strip}%%')"],
                 :order => 'id'        
      else
        paginate :per_page => 10,
                 :page => page,
                 :conditions => ["tiposcontrol_id = 10004 and fecha_vencimiento >= trunc(sysdate) 
                                  and persona_id not in (select distinct persona_id from controles where tiposcontrol_id = 10005)
                                  and persona_id in (select id from personas where autobuscar like '%%#{s.to_s.strip}%%')"],
                 :order => 'id'
      end
    end
  end  

  def nombredirector
    if self.persona.nro_envio == 'FORMACION AVANZADA'
      return 'María Clara Ramírez Atehortua'
    elsif self.persona.fecha_resolucion.strftime("%Y-%m-%d") > '2018-01-01'
      return 'María Clara Ramírez Atehortua'
    else
      return 'Miguel Andrés Silva Moyano'
    end
  end

  def fecharesol
    if self.persona.nro_envio == 'FORMACION AVANZADA'
      return '15 de Noviembre de 2017'
    elsif self.persona.fecha_resolucion.to_s != ""
      return self.namedateperson(self.persona.fecha_resolucion)
    else
      return '06 de Marzo de 2017'
    end
  end

  def namedateperson(fecha)
    day_names = ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"]
    month_names = ["","Enero","Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    dia = fecha.strftime("%w").to_i
    ndia = day_names[dia]
    mes = fecha.strftime("%m").to_i
    nmes = month_names[mes]
    fchcompleta = fecha.strftime("%d") + ' de ' + nmes + ' del ' + fecha.strftime("%Y")
    return fchcompleta
  end

end
