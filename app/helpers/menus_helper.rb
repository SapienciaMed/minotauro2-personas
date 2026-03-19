module MenusHelper
  def parametro_input_fecha(fecha)
    if fecha.to_s != ""
      content_tag(:div, class: "form-group") do
        select_tag 'ubicacion[mes]', options_for_select(select_mesanno, fecha), data: { width: '100%' }, class: 'form-control select2'
      end +
        content_tag(:div, class: "form-group") do
          content_tag(:br) do
            button_tag class: "btn btn-danger", style: 'margin-top: -27px;' do
              content_tag(:nil, "Buscar")
            end
          end
        end
    else
      content_tag(:div, class: "form-group") do
        select_tag 'ubicacion[mes]', options_for_select(select_mesanno, Time.now.strftime("%Y/%m")), data: { width: '100%' }, class: 'form-control select2'
      end +
        content_tag(:div, class: "form-group") do
          content_tag(:br) do
            button_tag class: "btn btn-danger", style: 'margin-top: -27px;' do
              content_tag(:nil, "Buscar")
            end
          end
        end
    end
  end

  def parametro_input_gestor(periodo)
    content_tag(:div, class: "form-group") do
      select_tag 'ubicacion[valor_alternativo]', options_for_select(Dashboardcalculado.select("to_number(valor_alternativo) as user_alternativo").where("modelo like '%%GestionGestor%%' and portafolio_id = #{is_portafolio} and to_char(fechakpi,'YYYY/MM') = '#{periodo}'").distinct.collect { |p| [User.find(p.user_alternativo).nombre.to_s, p.user_alternativo] }), data: { width: '100%' }, class: 'form-control select2'
    end +
      content_tag(:div, class: "form-group") do
        content_tag(:br) do
          button_tag class: "btn btn-danger", style: 'margin-top: -27px;' do
            content_tag(:nil, "Buscar")
          end
        end
      end
  end

  def parametro_input_semana(periodo)
    content_tag(:div, class: "form-group") do
      select_tag 'ubicacion[dato]', options_for_select(Fechas2contable.select("to_number(TO_CHAR(fecha, 'WW')) as dato").where("to_char(fecha, 'YYYY-MM') = '#{periodo.to_date.strftime('%Y-%m')}'").distinct.order("to_number(TO_CHAR(fecha, 'WW')) asc").collect { |p| ["Semana: #{p.dato}", p.dato] }), data: { width: '100%' }, class: 'form-control select2'
    end +
      content_tag(:div, class: "form-group") do
        content_tag(:br) do
          button_tag class: "btn btn-danger", style: 'margin-top: -27px;' do
            content_tag(:nil, "Buscar")
          end
        end
      end
  end

  def parametro_input_dia(periodo)
    content_tag(:div, class: "form-group") do
      select_tag 'ubicacion[dato]', options_for_select(Fechas2contable.select("to_number(TO_CHAR(fecha, 'DD')) as dato").where("to_char(fecha, 'YYYY-MM') = '#{periodo.to_date.strftime('%Y-%m')}'").distinct.order("to_number(TO_CHAR(fecha, 'DD')) asc").collect { |p| ["Dia: #{p.dato}", p.dato] }), data: { width: '100%' }, class: 'form-control select2'
    end +
      content_tag(:div, class: "form-group") do
        content_tag(:br) do
          button_tag class: "btn btn-danger", style: 'margin-top: -27px;' do
            content_tag(:nil, "Buscar")
          end
        end
      end
  end

  def desc_gestor(params)
    image_tag('user1.jpeg', class: "direct-chat-img") + " " + params.usuario_dashboad_gestion
  end

  def camponumerico_tipo_gestion(params)
    ['5. Valor Acuerdos', '6. Valor Cuota Acuerdos','7. Valor Recaudos'].include?(params.nombrekpi) ? camponumerico8(params.valor.to_i) : params.valor.to_i
  end
end

