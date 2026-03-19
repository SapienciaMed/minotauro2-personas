module PersonasobligacionesHelper

  def saldofavor(personasobligacion,datoid)
    return Objeto.find_by_sql(["select fnc_saldofavor(#{personasobligacion.id}) valor from dual"])[0].valor.to_f rescue 0
  end

  def select_fondo
    [
      ["FONDO MEDELLIN EPM","FONDO MEDELLIN EPM"],
      ["ENLAZAMUNDOS","ENLAZAMUNDOS"],
      ["ESPECIAL","ESPECIAL"],
      ["EXTENDIENDO FRONTERAS","EXTENDIENDO FRONTERAS"]
    ]
  end

  def select_amortizacion
    [
      ["FIJA","FIJA"],
      ["FLEXIBLE","FLEXIBLE"]
    ]
  end

  def select_pac
    [
      ["PRIORITARIOS", "PRIORITARIOS"],
      ["1", "1"],
      ["2", "2"],
      ["3", "3"],
      ["4", "4"],
      ["5", "5"],
      ["6", "6"],
      ["7", "7"],
      ["8", "8"],
      ["9", "9"],
      ["10", "10"],
      ["11", "11"],
      ["12", "12"],
      ["13", "13"],
      ["14", "14"],
      ["15", "15"],
      ["16", "16"],
      ["17", "17"],
      ["18", "18"],
      ["19", "19"],
      ["20", "20"],
      ["PACC 1 2019", "PACC 1 2019"],
      ["PACC 2 2019", "PACC 2 2019"],
      ["PACC 3 2019", "PACC 3 2019"],
      ["PACP 1 2019", "PACP 1 2019"],
      ["PACP 2 2019", "PACP 2 2019"]
    ]
  end

  def encabezado_obl_programas(oblId)
    "#{oblId.nombre_cliente} - #{oblId.partiposproducto.descripcion} - Obligación Nro #{oblId.nro_obligacion} - #{is_simbolo(oblId.simbolo)}".html_safe rescue nil
  end
end
