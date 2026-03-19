module PersonasHelper
  def users_for_personas_select
    User.where("portafolio_id = :id_portafolio AND encrypted_password IS NOT NULL AND activo = 'S'", id_portafolio: is_portafolio).order(:nombre)
  end
  
  def sucursales_for_personas_select
    Portafoliossucursal.order(:descripcion)
  end
  
  def originadores_for_personas_select
    Portafolioscontrato.order(:originador).select(:originador).distinct
  end
  
  def contratos_for_personas_select
    Portafolioscontrato.order(:nombre)
  end
  
  def productos_for_personas_select
    Covinocobligacion.group(:sub_producto).select(:sub_producto).distinct
  end
  
  def claseNormalizaciones_for_personas_select
    Personasacuerdo.group(:descripcion).select(:descripcion).distinct
  end
  
  def estadoNormalizaciones_for_personas_select
    Personasacuerdo.group(:estado).select(:estado).distinct
  end

  def pecuniarios_all_select
    Objeto.find_by_sql(["select up.id, p.nombre
                        from pecuniarios p, universidadespecuniarios up
                        where p.estado = 'ACTIVO' 
                        and   p.id = up.pecuniario_id
                        and   up.universidad_id = #{@persona.programaform.universidadesprograma.universidad_id} 
                        and   up.tipo_programa = '#{@persona.programaform.universidadesprograma.tipo}' 
                        and   up.fecha_vencimiento >= trunc(SYSDATE)
                        order by p.nombre"])
  end
  
  def tipoInformes_for_personas_select
    [ 
      ["EXCEL", "EXCEL"],
      ["EN PANTALLA", "EN PANTALLA"]
    ]
  end

  def select_dato_asociado
    Objeto.find_by_sql(["select id, primer_nombre||' '||segundo_nombre||' '||primer_apellido||' '||segundo_nombre||' - '||tipo nom
          from personascodeudores where persona_id = #{@persona.id}
          union
          select -1, nombre_completo||' - DEUDOR PRINCIPAL' nom from personas where id = #{@persona.id}
          "])
  end


  def descripcion_tablavista_columna7(params)
    case params
    when 10040
      'Producto'
    else
      'Sucursal'
    end
  end

  def select_demandante
     is_portafoliosdemandante.present? && is_tipoconsulta == 'DEMANDANTE' ?
       Portafoliosdemandante.where("portafolio_id = ? and id = ?", is_portafolio, is_portafoliosdemandante) :
       Portafoliosdemandante.where("portafolio_id = ?", is_portafolio)
  end
end
