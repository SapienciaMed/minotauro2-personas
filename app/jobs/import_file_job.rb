class ImportFileJob < ApplicationJob

  queue_as :sidekiq

  def perform(path, is_portafolio, metodo, *args)
    if metodo == 'importar'
      #Proceso de cargue de Novedades de Covinoc
      Proceso.importar(path, is_portafolio)
    elsif metodo == 'importar1'
      #Proceso de cargue de Pagos de Covinoc
      Proceso.importar1(path, is_portafolio)
    elsif metodo == 'importar_cargar2'
      #Proceso de importacion de gestiones KFG y Four
      Proceso.importar_cargar2(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarpagosobligaciones'
      Proceso.importar_cargarobligaciones(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargar2pagos'
      Proceso.importar_cargar2pagos(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargargca'
      Proceso.importar_cargargca(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_asignaciones'
      Proceso.importar_asignaciones(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'cargar3pagos'
      Proceso.importar_recaudos(is_portafolio, args[0], args[1])
    elsif metodo == 'importar_asig_agencia'
      Proceso.importar_asig_agencia(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_asig_asesor'
      Proceso.importar_asig_asesor(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_asig_asesor'
      Proceso.importar_asig_asesor(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_edupolrecaudos'
      Edupolrecaudo.importar_edupolrecaudos(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'alianzas_importar'
      Alianza.importar(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'convenios_importar'
      Convenio.importar(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'users_importar'
      User.importar(path, is_portafolio, args[0], args[1])
    elsif metodo == 'creditos_importar'
      Cohortesprogreingreso.importar(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'creditos_renovaciones_importar'
      Cohortesprogperiodo.importar(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'creditos_nuevos_importar'
      Cohortesprograma.importar(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'users_importar2'
      User.importar2(path, is_portafolio, args[0], args[1])
    elsif metodo == 'importar_gastos'
      Proceso.importar_gastos(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_tanque'
      #Proceso de importacion de Tanques
      Tanque.importar_tanque(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_extinciones'
      Proceso.importar_extinciones(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'gerentes_importar'
      Centro.importar_gerentes(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_personas'
      Proceso.importar_personas(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_obligaciones'
      Proceso.importar_obligaciones(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_telefonos'
      Proceso.importar_telefonos(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_direcciones'
      Proceso.importar_direcciones(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_correos'
      Proceso.importar_correos(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_laborales'
      Proceso.importar_laborales(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarestudios'
      #Proceso de importacion de gestiones estudios GPS
      Proceso.importar_cargarestudios(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_etapas_procesales'
      #Proceso de importacion de gestiones estudios GPS
      Proceso.importar_etapas_procesales(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_tanquesobl'
      #Proceso de importacion de Tanque Obligaciones
      Tanquesmasivo.importar_tanquesobl(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_codeudores'
      #Proceso de importacion de Tanque Obligaciones
      Proceso.importar_codeudores(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_marcaciones'
      Proceso.importar_marcaciones(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_gestionesvir'
      Proceso.importar_gestionesvir(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_analistas'
      #Proceso de importacion de Estudios - Analistas
      Proceso.importar_analistas(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_estudiosprocesos'
      #Proceso de importacion de Estudios - Procesos
      Proceso.importar_estudiosprocesos(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_fourcapital'
      #Proceso de importacion para Fourcapital
      Proceso.importar_fourcapital(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_campanas'
      Proceso.importar_campanas(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cesiones'
      Proceso.importar_cesiones(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarprogramaciones'
      Proceso.importar_cargarprogramaciones(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_asignacionesprocesos'
      Proceso.importar_asignacionesprocesos(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_atencion'
      Proceso.importar_atencion(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_autorizaciones'
      Proceso.importar_autorizaciones(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'procesosalertas'
      Personasproetapasalerta.procesosalertas(path,is_portafolio)
    elsif metodo == 'procesosalertasgps'
      Personasproetapasalerta.procesosalertasgps
    elsif metodo == 'importar_gastosreo'
      Proceso.importar_gastosreo(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_respuestabcp'
      Proceso.importar_respuestabcp(path, is_portafolio, args[0], args[1], args[2], args[3], args[4])
    elsif metodo == 'importar_icetexestados'
      Icetexgestion.importar_icetexestados(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_generarpazysalvos'
      Proceso.importar_generarpazysalvos(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_fitsolicitudes'
      Proceso.importar_fitsolicitudes(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_equifaxsolicitudes'
      Proceso.importar_equifaxsolicitudes(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_marcacionbloqueo'
      Proceso.importar_marcacionbloqueo(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_tipocartera'
      Proceso.importar_tipocartera(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_obligacionessistemcobro'
      Proceso.importar_obligacionessistemcobro(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_judicial'
      Proceso.importar_judicial(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'import_parentescos'
      Proceso.import_parentescos(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_oblbbva'
      Proceso.importar_oblbbva(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargar2pagosbbva'
      Proceso.importar_cargar2pagosbbva(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarrecsullana'
      Proceso.importar_cargarrecsullana(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarrechuancayo'
      Proceso.importar_cargarrechuancayo(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarrecfit'
      Proceso.importar_cargarrecfit(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarrecbbvafit'
      Proceso.importar_cargarrecbbvafit(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarrecinterbankfit'
      Proceso.importar_cargarrecinterbankfit(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_gpscampanas'
      Campana.importar_gpscampanas(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_cargarcesionprocesal'
      Proceso.importar_cargarcesionprocesal(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargaranalistasces'
      Proceso.importar_cargaranalistasces(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarsemestres'
      Proceso.importar_cargarsemestres(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarasignacionespqrs'
      Proceso.importar_cargarasignacionespqrs(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'import_centrales'
      Proceso.import_centrales(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_cargarrecaudosbbva'
      Proceso.importar_cargarrecaudosbbva(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_carguegastosfna'
      Proceso.importar_carguegastosfna(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_carguedescuentos'
      Proceso.importar_carguedescuentos(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarprecios'
      Proceso.importar_cargarprecios(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_carguesegpazysalvos'
      Proceso.importar_carguesegpazysalvos(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargarnotificaciones'
      Proceso.importar_cargarnotificaciones(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_cargaranalistaspqrs'
      Proceso.importar_cargaranalistaspqrs(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_estadosestudiantes'
      Proceso.importar_estadosestudiantes(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_fallecidopersonas'
      Proceso.importar_fallecidopersonas(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_procesosgca'
      Proceso.importar_procesosgca(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_procesosobldatos'
      Proceso.importar_procesosobldatos(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_procesosotros'
      Proceso.importar_procesosotros(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_proceso_acuerdo_plan_pagos'
      Proceso.importar_proceso_acuerdo_plan_pagos(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_progreso'
      Proceso.importar_progreso(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_fchterminacion'
      Proceso.importar_fchterminacion(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_nropagare'
      Proceso.importar_nropagare(path, is_portafolio, args[0], args[1], args[2], args[3])
    elsif metodo == 'importar_cambiovalores'
      Proceso.importar_cambiovalores(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_iesconfirmarlote'
      Proceso.importar_iesconfirmarlote(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_confirmarlote'
      Proceso.importar_confirmarlote(path, is_portafolio, args[0], args[1], args[2])
    elsif metodo == 'importar_cargueotrosrecaudo'
      # Descripcion: Metodo para cargar proceso otros recuados - Procesocargueobl (Herencia de Proceso)
      # Fecha Creacion: 24-Marzo-2022
      # Autor: AFP
      Procesocargueobl.importar_cargueotrosrecaudo(path, is_portafolio, args[0], args[1], args[2], args[3])
    end
  end
end
