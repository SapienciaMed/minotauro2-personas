class RecordacionesController < ApplicationController
  layout :determine_layout

  def index
    if Time.now.strftime("%X") >= "02:00:00" and Time.now.strftime("%X") >= "04:00:00"
      ActiveRecord::Base.connection.execute("begin prc_pac; end;")        
      @recordacion = Recordacion.new
      @recordacion.fecha = Time.now
      @recordacion.descripcion = "Deteccion de Etapa PAC"
      @recordacion.save
    end
    if Recordacion.exists?(["trunc(fecha) = trunc(sysdate)"]) == true
      flash[:notice] = "Ya fue enviado"
    else
      if Time.now.strftime("%X") >= "10:00:00"
        #ActiveRecord::Base.connection.execute("begin prc_obligacionmora; end;")
        ActiveRecord::Base.connection.execute("begin prc_pac; end;")
        @recordacion = Recordacion.new
        @recordacion.fecha = Time.now
        @recordacion.descripcion = "Proceso de Mora"
        @recordacion.save
      end
    end
    @recordaciones = Recordacion.find(:all, :limit=> 10, :order =>"fecha desc")
  end

  private
  def determine_layout
    if ['index'].include?(action_name)
      "automatic"
    else
      "application"
    end
  end
end
