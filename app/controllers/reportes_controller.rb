class ReportesController < ApplicationController
  
  before_filter :require_user
  layout :determine_layout


  def portafolio

  end
  
  def index
  end

  def indexpac
  end

  def controles
    if params[:ubicacion][:tiposcontrol_id].to_s != ""
      headers['Content-Type'] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = 'attachment; filename="Minotauro_controlpac_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = ''
      @controles = Control.find(:all, :conditions=>["tiposcontrol_id = '#{params[:ubicacion][:tiposcontrol_id].to_s}'"], :order=>"fecha desc")
    else
      flash[:warning] = "No hay resultados de la busqueda "
      redirect_to indexpac_reportes_path
    end
  end

  def infoevolucionrecaudo
    ActiveRecord::Base.connection.execute("begin prc_informesrecaudo; end;")
  end

  def infoconsola
    ActiveRecord::Base.connection.execute("begin prc_informesrecaudo; end;")
  end

  def infoorigen
    ActiveRecord::Base.connection.execute("begin prc_informeorigencartera; end;")
    @objetos = Objeto.find_by_sql(["select * from informeorigencartera"])
  end

  def infoamorti
    ActiveRecord::Base.connection.execute("begin prc_informeorigencartera; end;")
    @objetos = Objeto.find_by_sql(["select sum(cantidad) c, sum(saldo_inicial) si, sum(saldo_deuda) sd, sum(recaudo) re from informeorigencartera"])
  end

  def infoasigna
    ActiveRecord::Base.connection.execute("begin prc_informeasigcartera; end;")
    @objetos = Objeto.find_by_sql(["select * from informeasigcartera"])
  end

  def inforeca
    ActiveRecord::Base.connection.execute("begin prc_informesrecmensual; end;")
    @objetos = Objeto.find_by_sql(["select * from informesrecmensual"])
  end
  
  def inforecaacum
    ActiveRecord::Base.connection.execute("begin prc_informesrecmensual; end;")
    @objetos = Objeto.find_by_sql(["select * from informesrecmensual"])    
  end

  def informedemografico
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="Minotauro_Demograficos_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @personas = Persona.find(:all)# ,:limit=>20) #, :conditions=>["persona_id in (select id from personas where radicado is not null or radicado1 is not null or radicado2 is not null)"])
  end

  private
  def determine_layout
    if ['informedemografico','controles'].include?(action_name)
      "informes"
    elsif ['infoevolucionrecaudo'].include?(action_name)
      "basico"
    elsif ['infoconsola','portafolio','infoorigen','infoamorti','infoasigna','inforeca','inforecaacum'].include?(action_name)
      "basicoreporte"
    else
      "application"
    end
  end
end
