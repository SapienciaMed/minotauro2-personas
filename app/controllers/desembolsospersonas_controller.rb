class DesembolsospersonasController < ApplicationController
  before_filter :require_user
  require 'ruby_plsql'
  layout :determine_layout

  def index
    #dato  = params[:ubicacion][:proyecto].to_s rescue nil
    #dato2 = params[:ubicacion][:tipo].to_s rescue nil
    perpage = 15
    @desembolsospersonas =  Desembolsospersona.search(params[:identificacion],params[:nombre],params[:page],perpage)    
    if @desembolsospersonas.count == 0
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @desembolsospersonas }
      end        
    elsif @desembolsospersonas.count == 1
      redirect_to edit_desembolsospersona_path(:id=>@desembolsospersonas, :etapa=>"1")   
    end
  end

  def show
    @desembolsospersona = Desembolsospersona.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @desembolsospersona }
    end
  end

  def informe
    fondo = params[:ubicacion][:fondo].to_s
    convocatoria = params[:ubicacion][:convocatoria].to_s
    ies = params[:ubicacion][:ies].to_s
    operador_financiero = params[:ubicacion][:operador_financiero].to_s
    @formato = params[:ubicacion][:formato].to_s
    if fondo == "" and convocatoria == "" and ies == "" and operador_financiero == ""
      flash[:warning] = "Debe indicar minimo un parametro de consulta"
      redirect_to desembolsospersonas_path
    else
      cadena = ""
      if fondo != ""
        if cadena != ""
          cadena = cadena + ' and fondo  = '+ "'#{fondo.to_s}'"
        else
          cadena = cadena + ' fondo  = '+ "'#{fondo.to_s}'"
        end
      end
      if convocatoria != ""
        if cadena != ""
          cadena = cadena + ' and convocatoria  = '+ "'#{convocatoria}'"
        else
          cadena = cadena + ' convocatoria  = '+ "'#{convocatoria}'"
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
      if @formato.to_s == 'CONSOLIDADO' or @formato.to_s == ""
        headers['Content-Type'] = "application/vnd.ms-excel"
        headers['Content-Disposition'] = 'attachment; filename="Contabilidad_C_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
        headers['Cache-Control'] = 'max-age=0'
        headers['pragma']="public"      
        @informes = Objeto.find_by_sql(["select fondo, convocatoria, ies, operador_financiero, sum(nvl(totaldesembolsado,0)) t1, sum(nvl(credito,0)) c1, sum(nvl(simulacion,0)) s1 from view_contable
                                        where #{cadena.to_s}
                                        group by fondo, convocatoria, ies, operador_financiero"])
        if @informes.count == 0
          flash[:warning] = "No hay resultados de la busqueda"
          redirect_to desembolsospersonas_path
        end
      else
        headers['Content-Type'] = "application/vnd.ms-excel"
        headers['Content-Disposition'] = 'attachment; filename="Contabilidad_D_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
        headers['Cache-Control'] = 'max-age=0'
        headers['pragma']="public"      
        @informes = Objeto.find_by_sql(["select fondo, convocatoria, ies, operador_financiero, sum(nvl(totaldesembolsado,0)) t1, sum(nvl(credito,0)) c1, sum(nvl(simulacion,0)) s1, documento, nombre_completo from view_contable
                                         where #{cadena.to_s}
                                         group by fondo, convocatoria, ies, operador_financiero,documento, nombre_completo"])
        if @informes.count == 0
          flash[:warning] = "No hay resultados de la busqueda"
          redirect_to desembolsospersonas_path
        end
      end
    end
  rescue 
    flash[:warning] = "Problemas con la consulta..."
    redirect_to desembolsospersonas_path
  end

  def visualizar
    @desembolsospersona = Desembolsospersona.find(params[:id])
  end

  def edit
    @desembolsospersona = Desembolsospersona.find(params[:id])
    respond_to do |format|
      format.html { render :action => "desembolsospersona_form" }
    end
  end

  private
  def determine_layout
    if ['informe'].include?(action_name)
      "informes"
    else
      "application"
    end
  end
end
