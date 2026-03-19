module LinkBarHelper

  def auth?(accion, permiso)
    case accion
    when 'C' then auth_c?(permiso)
    when 'A' then auth_a?(permiso)
    when 'E' then auth_e?(permiso)
    end
  end

  def link?(tipo, _link)
    tipo == 'remote'
  end

  def type_buttom?(accion)
    case accion
    when 'C' then 'success'
    when 'A' then 'warning'
    when 'E' then 'danger'
    when 'I' then 'primary'
    end
  end

  def method?(accion)
    accion == 'E' ? :delete : nil
  end

  def confirm?(accion)
    accion == 'E' ? I18n.t("confirmacion") : nil
  end

  def link_bar_universal(link, icono, titulo, accion, permiso, tipo)
    status = permiso ? auth?(accion, permiso) : true
    if status
      link_to link, remote: link?(tipo, link),
                    class: "btn btn-xs btn-#{type_buttom?(accion)}",
                    title: titulo,
                    method: method?(accion),
                    data: { toggle: 'tooltip',
                            confirm: confirm?(accion) } do
        content_tag(:i) do
          fa_icon(icono)
        end
      end
    end
  end
end
