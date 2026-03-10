# frozen_string_literal: true

module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def irregular_types(type)
    case type
    when 'alert'
      'danger'
    when 'notice'
      'success'
    else
      type
    end
  end

  def difference_dates(date)
    days = (date.to_date - Date.today).to_i
    return days
  end

  def select_sino
    [
      ["SI","SI"],
      ["NO","NO"]
    ]
  end

  def select_tipo_envio_epayco
    [
      ["EMAIL","EMAIL"],
      ["SMS","SMS"],
      ["LINK DE COBRO","LINK DE COBRO"]

    ]
  end

  def select_clasedeudor
    [
      ["DEUDOR PRINCIPAL","DEUDOR PRINCIPAL"],
      ["DEUDOR SOLIDARIO","DEUDOR SOLIDARIO"]
    ]
  end

  def select_situacion_bene
    [
      ["CULMINO EXITOSAMENTE PROGRAMA FINANCIADO","CULMINO EXITOSAMENTE PROGRAMA FINANCIADO"],
      ["CULMINO EXITOSAMENTE PROGRAMA DIFERENTE AL FINANCIADO","CULMINO EXITOSAMENTE PROGRAMA DIFERENTE AL FINANCIADO"],
      ["DESERTO DE ESTUDIOS SUPERIORES","DESERTO DE ESTUDIOS SUPERIORES"],
      ["CONTINUA ESTUDIANDO EL PROGRAMA FINANCIADO","CONTINUA ESTUDIANDO EL PROGRAMA FINANCIADO"],
      ["INICIO ESTUDIOS DIFERENTES AL FINANCIADO","INICIO ESTUDIOS DIFERENTES AL FINANCIADO"],
      ["SIN DATO","SIN DATO"]
    ]
  end

  
  def select_tiposatencion
    [
      ["PERSONALIZADA","PERSONALIZADA"],
      ["TELEFONICA","TELEFONICA"],
      #["DOMICILIARIA","DOMICILIARIA"],
      ["CORREO FISICO","CORREO FISICO"],
      ["CORREO ELECTRONICO","CORREO ELECTRONICO"],
      ["OTRA","OTRA"]
    ]
  end

  def select_tipodocumentoim
    [
      ["RESOLUCIONES","RESOLUCIONES"],
      ["FACTURACION","FACTURACION"],
      ["QUEJAS Y RECLAMOS","QUEJAS Y RECLAMOS"],
      ["NORMALIZACION CREDITO","NORMALIZACION CREDITO"],
      ["GARANTIAS","GARANTIAS"],
      ["NOTIFICACIONES PLANES DE AMORTIZACION","NOTIFICACIONES PLANES DE AMORTIZACION"],
      ["APROBACION DE CAMBIOS","APROBACION DE CAMBIOS"],
      ["PAZ Y SALVO","PAZ Y SALVO"],
      ["CITACION","CITACION"],
      ["EXPEDIENTE","EXPEDIENTE"],
      ["RESOLUCION","RESOLUCION"],
      ["COBRO PREJURIDICO","COBRO PREJURIDICO"],
      ["CAMBIOS, MODIFICACIONES Y ACLARACIONES","CAMBIOS, MODIFICACIONES Y ACLARACIONES"],
      ["ACTUALIZACIÓN DE DATOS", "ACTUALIZACIÓN DE DATOS"]
    ]
  end

  def select_tipo
    [
      ["RESIDENCIA","RESIDENCIA"],
      ["OFICINA","OFICINA"],
      ["CELULAR","CELULAR"],
      ["OTRA","OTRA"],
      ["LUGAR DESHABITADO","LUGAR DESHABITADO"],
      ["COMERCIAL","COMERCIAL"],
      ["CORRESPONDENCIA","CORRESPONDENCIA"]
    ]
  end

  def select_oficinaregistro
    return is_select_oficinaregistro
  end

  def select_notaria
    return is_select_notaria
  end

  def select_tipoproceso
    [
      ["EJECUTIVO SINGULAR","EJECUTIVO SINGULAR"],
      ["EJECUTIVO MIXTO","EJECUTIVO MIXTO"],
      ["EJECUTIVO HIPOTECARIO","EJECUTIVO HIPOTECARIO"],
      ["EJECUTIVO PRENDARIO","EJECUTIVO PRENDARIO"],
      ["CONCURSAL","CONCURSAL"]
    ]
  end  
  
  def select_tipojuzgado
    [
      ["CIVIL MUNICIPAL","CIVIL MUNICIPAL"],
      ["CIVIL DEL CIRCUITO","CIVIL DEL CIRCUITO"],
      ["PROMISCUO MUNICIPAL","PROMISCUO MUNICIPAL"],
      ["PROMISCUO DE CIRCUITO","PROMISCUO DE CIRCUITO"],
      ["TRIBUNAL SUPERIOR","TRIBUNAL SUPERIOR"],
      ["CORTE SUPREMA","CORTE SUPREMA"]
    ]
  end 
  
  def select_estadoproceso
    [
      ["ACTIVO","ACTIVO"],
      ["SUSPENDIDO","SUSPENDIDO"],
      ["TERMINADO","TERMINADO"]
    ]
  end

  def select_tipodoc
    [
      ["C.C.","C.C."],
      ["T.I.","T.I."]
    ]
  end

  def select_termino
    [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6]]
  end

  def select_propuesta1
    [
      ["ACUERDO DE PAGO - EFECTIVO","ACUERDO DE PAGO - EFECTIVO"],
      ["ACUERDO DE PAGO - PLAZO","ACUERDO DE PAGO - PLAZO"],
      ["REESTRUCTURACION","REESTRUCTURACION"],
      ["REESTRUCTURACION COVID","REESTRUCTURACION COVID"],
      ["REMATE","REMATE"],
      ["CONGELAMIENTO OBLIGACION","CONGELAMIENTO OBLIGACION"],
      ["OTRAS SOLICITUDES","OTRAS SOLICITUDES"]
    ]
  end

  def select_propuesta2
    [
      ["AMPLIACION DE PLAZO","AMPLIACION DE PLAZO"],
      ["DISMINUCION DE PLAZO","DISMINUCION DE PLAZO"],
      ["ACUERDO DE PAGO - EFECTIVO","ACUERDO DE PAGO - EFECTIVO"],
      ["ACUERDO DE PAGO - PLAZO","ACUERDO DE PAGO - PLAZO"],
      ["REESTRUCTURACION","REESTRUCTURACION"],
      ["REESTRUCTURACION COVID","REESTRUCTURACION COVID"],
      ["REMATE","REMATE"],
      ["CONGELAMIENTO OBLIGACION","CONGELAMIENTO OBLIGACION"],
      ["OTRAS SOLICITUDES","OTRAS SOLICITUDES"]
    ]
  end

  def select_user
    return is_select_user
  end

  def select_procesopersona
    [
      ["NINGUNO","NINGUNO"],
      ["BENEFICIARIOS ADMITIDOS EN PROCESOS DE INSOLVENCIA DE PERSONA NATURAL NO COMERCIANTE","BENEFICIARIOS ADMITIDOS EN PROCESOS DE INSOLVENCIA DE PERSONA NATURAL NO COMERCIANTE"]
    ]
  end


  def select_claseicetexestados
    [
      %w[ICETEX ICETEX],
      %w[EDUPOL EDUPOL]
    ]
  end

  def select_claseicetexestados2
    [
      %w[ICETEX ICETEX],
      %w[EXPERIENCIA EXPERIENCIA]
    ]
  end

  def select_ambitogps
    [
      %w[GPS GPS],
      %w[AGENCIA AGENCIA],
      ['AGENCIA JURIDICA', 'AGENCIA JURIDICA'],
      %w[ESTUDIO ESTUDIO]
    ]
  end

  def select_claseprocesosnpl
    [
      %w[CONCURSALES CONCURSALES],
      ['NEG DE DEUDAS', 'NEG DE DEUDAS']
    ]
  end

  def select_statuspagogastos
    [
      ['ACUERDO DE PAGO VIGENTE', 'ACUERDO DE PAGO VIGENTE'],
      %w[CUMPLIENDO CUMPLIENDO],
      ['CUMPLIENDO PARCIALMENTE', 'CUMPLIENDO PARCIALMENTE'],
      %w[INCUMPLIO INCUMPLIO],
      ['NO APLICA', 'NO APLICA']
    ]
  end

  def select_aplicacionnpl
    [
      %w[APLICADO APLICADO],
      %w[CODEUDOR CODEUDOR],
      %w[INCUMPLIO INCUMPLIO],
      %w[LEASING LEASING],
      %w[PENDIENTE PENDIENTE],
      ['PENDIENTE POR APLICAR', 'PENDIENTE POR APLICAR']
    ]
  end

  def select_statusacuerdonpl
    [
      ['CUMPLIENDO PARCIALMENTE', 'CUMPLIENDO PARCIALMENTE'],
      ['PERIODO DE GRACIA', 'PERIODO DE GRACIA']
    ]
  end

  def select_cobrojudicialnpl
    [
      ['EJECUTIVO MIXTO', 'EJECUTIVO MIXTO'],
      ['EJECUTIVO SINGULAR', 'EJECUTIVO SINGULAR'],
      ['PROCESO EJECUTIVO MIXTO', 'PROCESO EJECUTIVO MIXTO'],
      ['PROCESO EJECUTIVO SINGULAR', 'PROCESO EJECUTIVO SINGULAR'],
      %w[RESTITUCION RESTITUCION],
      ['SIN PROCESO', 'SIN PROCESO'],
      ['TRAMITE DE PAGO DIRECTO', 'TRAMITE DE PAGO DIRECTO'],
      ['TRAMITE PAGO DE DIRECTO', 'TRAMITE PAGO DE DIRECTO'],
      ['TRAMITE PAGO DIRECTO', 'TRAMITE PAGO DIRECTO']
    ]
  end

  def estados_documentacion
    [
      ['Sin solicitud Web', 'Sin solicitud Web'],
      ['Con Web - Escalado a la IES', 'Con Web - Escalado a la IES'],
      ['Con Web - Sin documentos', 'Con Web - Sin documentos'],
      ['Con Web - Documentos con inconsistencias', 'Con Web - Documentos con inconsistencias'],
      ['Con Web - Documentos Completos', 'Con Web - Documentos Completos'],
      ['Escalado a la IES - Pendiente de respuesta', 'Escalado a la IES - Pendiente de respuesta'],
      ['Admitido IES', 'Admitido IES'],
      %w[Entrevista Entrevista],
      ['No admitido por estar fuera de fecha', 'No admitido por estar fuera de fecha']
    ]
  end

  def estados_documentacionexp
    [
      ['Inscripción en la Universidad', 'Inscripcion en la Universidad'],
      ['Pago de la Inscripción a la IES', 'Pago de la Inscripcion a la IES'],
      ['Pago Matrícula IES - Experiencia', 'Pago Matricula IES - Experiencia'],
      ['Sin solicitud Web', 'Sin solicitud Web'],
      ['Con Web - Sin documentos', 'Con Web - Sin documentos'],
      ['Con Web - Documentos con inconsistencias', 'Con Web - Documentos con inconsistencias'],
      ['Con Web - Documentos Completos', 'Con Web - Documentos Completos'],
      ['Documentos cargue IES - Experiencia', 'Documentos cargue IES - Experiencia'],
      ['Admitido IES', 'Admitido IES'],
      %w[Entrevista Entrevista],
      ['No admitido por estar fuera de fecha', 'No admitido por estar fuera de fecha'],
      ['Matriculado IES', 'Matriculado IES'],
      ['Adoptado', 'Adoptado'],
      ['Estudiante Perdido', 'Estudiante Perdido']
    ]
  end

  def select_tipoedupol
    [
      %w[ANTIGUOS ANTIGUOS],
      %w[NUEVOS NUEVOS]
    ]
  end

  def select_charterbank
    [
      %w[HUANCAYO HUANCAYO],
      %w[SULLANA SULLANA]
    ]
  end

  def select_tipogastos
    [
      ['Cargue Gastos Procesales', 'GASTOS PROCESALES'],
      ['Cargue Gastos Reo', 'GASTOS REO'],
      ['Cargue Respuesta Bcp', 'RESPUESTA BCP']
    ]
  end

  def hiddenproceso
    %w[
      CARGARPERSONAS CARGARGESTIONES CARGARESTUDIOS
      CARGARATENCION CARGARESTADOSICETEX CARGARTANQUE IMPORTETAPAS IMPORTANALISTAS
      IMPORTCAMPANA IMPORTCODEUDORES GESTIONESVIRTUALES CARGUEMARCACIONES CARGUEOBLIGACIONES IMPORTGCA IMPORTPAGOS
      IMPORTCESION IMPORTEXTINCION IMPORTASIGNACIONES IMPORTAGENCIA IMPORTARALIANZA
      CARGUESOLICITUDESFIT CARGUESOLICITUDESEQUIFAX IMPORTMARCACIONBLOQUEO IMPORTTIPOCARTERA
      CARGUEOBLIGACIONESSISTEMCOBRO IMPORTJUDICIAL IMPORTPARENTESCOS CARGUEOBLBBVA
      IMPORTPAGOSBBVA CARGUECAMPANAGPS 
      IMPORTASIGNACOLTE
    ]
  end

  def select_tipometodourl
    [
      %w[GET GET],
      %w[POST POST]
    ]
  end

  def select_resultado
    [
      %w[POSITIVO POSITIVO],
      %w[NEGATIVO NEGATIVO]
    ]
  end

  def select_diasmora
    [
      ['Al Día', '0 and 0'],
      ['1 - 30', '1 and 30'],
      ['31 - 60', '31 and 60'],
      ['61 - 90', '61 and 90'],
      ['91 - 180', '91 and 180'],
      ['181 - 360', '181 and 360'],
      ['Mas de 360 Días', '361 and 100000']
    ]
  end

  def select_tipoprogramaedupol
    [
      ['TECNICA PROFESIONAL', 'TECNICA PROFESIONAL'],
      %w[TECNOLOGÍA TECNOLOGIA],
      %w[PROFESIONAL PROFESIONAL],
      ['CURSOS ESPECIALES', 'CURSOS ESPECIALES'],
      %w[ESPECIALIZACIÓN ESPECIALIZACION],
      %w[MAESTRÍA MAESTRIA],
      %w[DIPLOMADOS DIPLOMADOS],
      ['DOCTORADO', 'DOCTORADO']
    ]
  end

  def select_tipogastojudicial
    [
      %w[JUDICIAL JUDICIAL],
      %w[NOTARIAL NOTARIAL],
      %w[REGISTRAL REGISTRAL],
      %w[DILIGENCIAMIENTO DILIGENCIAMIENTO]
    ]
  end

  def estado_edupolgeneral(est)
    case est
    when 'APPROVED'
      'Aprobada'
    when 'DECLINED'
      'Rechazada'
    when 'EXPIRED'
      'Expirada'
    when 'PENDING'
      'Pendiente'
    else
      'Error'
    end
  end

  def metodospago(metodo)
    case metodo
    when 'CREDIT_CARD'
      'Tarjeta de Crédito'
    when 'PSE'
      'PSE'
    when 'ACH'
      'Tarjeta Débito'
    when 'CASH'
      'Efectivo'
    when 'REFERENCED'
      'Pago Referenciado'
    when 'BANK_REFERENCED'
      'Pago en Banco'
    end
  end

  def estado_edupol(estado)
    case estado
    when 'APPROVED'
      'Transacción aprobada'
    when 'PAYMENT_NETWORK_REJECTED'
      'Transacción rechazada por entidad financiera'
    when 'ENTITY_DECLINED'
      'Transacción rechazada por el banco'
    when 'INSUFFICIENT_FUNDS'
      'Fondos insuficientes'
    when 'INVALID_CARD'
      'Tarjeta inválida'
    when 'CONTACT_THE_ENTITY'
      'Contactar entidad financiera'
    when 'BANK_ACCOUNT_ACTIVATION_ERROR'
      'Débito automático no permitido'
    when 'BANK_ACCOUNT_NOT_AUTHORIZED_FOR_AUTOMATIC_DEBIT'
      'Débito automático no permitido'
    when 'INVALID_BANK'
      'Débito automático no permitido'
    when 'INVALID_BANK_ACCOUNT'
      'Débito automático no permitido'
    when 'INVALID_AGENCY_BANK_ACCOUNT'
      'Débito automático no permitido'
    when 'EXPIRED_CARD'
      'Tarjeta vencida'
    when 'RESTRICTED_CARD'
      'Tarjeta restringida'
    when 'INVALID_EXPIRATION_DATE_OR_SECURITY_CODE'
      'Fecha de expiración o código de seguridad inválidos'
    when 'REPEAT_TRANSACTION'
      'Reintentar pago'
    when 'INVALID_TRANSACTION'
      'Transacción inválida'
    when 'EXCEEDED_AMOUNT'
      'El valor excede el máximo permitido por la entidad'
    when 'ABANDONED_TRANSACTION'
      'Transacción abandonada por el pagador'
    when 'CREDIT_CARD_NOT_AUTHORIZED_FOR_INTERNET_TRANSACTIONS'
      'Tarjeta no autorizada para comprar por internet'
    when 'ANTIFRAUD_REJECTED'
      'Transacción rechazada por sospecha de fraude'
    when 'DIGITAL_CERTIFICATE_NOT_FOUND'
      'Certificado digital no encontrado'
    when 'BANK_UNREACHABLE'
      'Error tratando de cominicarse con el banco'
    when 'ENTITY_MESSAGING_ERROR'
      'Error comunicándose con la entidad financiera'
    when 'NOT_ACCEPTED_TRANSACTION'
      'Transacción no permitida al tarjeta habiente'
    when 'PAYMENT_NETWORK_NO_CONNECTION'
      'No fue posible establecer comunicación con la entidad financiera'
    when 'PAYMENT_NETWORK_NO_RESPONSE'
      'No se recibió respuesta de la entidad financiera'
    when 'EXPIRED_TRANSACTION'
      'Transacción expirada'
    when 'PENDING_TRANSACTION_REVIEW'
      'Transacción en validación manual'
    when 'PENDING_TRANSACTION_CONFIRMATION'
      'Recibo de pago generado. En espera de pago'
    when 'PENDING_TRANSACTION_TRANSMISSION'
      'Transacción no permitida'
    when 'PENDING_PAYMENT_IN_ENTITY'
      'Recibo de pago generado. En espera de pago'
    when 'PENDING_PAYMENT_IN_BANK'
      'Recibo de pago generado. En espera de pago'
    when 'PENDING_AWAITING_PSE_CONFIRMATION'
      'En espera de confirmación de PSE'
    when 'PENDING_NOTIFYING_ENTITY'
      'Recibo de pago generado. En espera de pago'
    else
      'Error'
    end
  end

  def select_tipocode
    [
      %w[VISTA VISTA],
      %w[CONTROLADOR CONTROLADOR],
      %w[MODELO MODELO]
    ]
  end

  def select_fuente
    [
      ['RECAUDO MES', 'RECAUDO MES'],
      ['RECAUDO TANQUE', 'RECAUDO TANQUE']
    ]
  end

  def select_tipoviv
    [
      %w[VIS S],
      ['NO VIS', 'N']
    ]
  end

  def tipousercentro
    [
      %w[COMERCIAL COMERCIAL],
      %w[ANALISTA ANALISTA]
    ]
  end

  def calcular_porcentaje(value1, value2)
    val = value2.to_f / value1.to_f
    val.to_f * 100
  end

  def calcular_restante(value1, value2)
    value1.to_f - value2.to_f
  end

  def log_actions(value)
    case value
    when 'destroy'
      'Eliminar'
    when 'create'
      'Crear'
    when 'update'
      'Actualizar'
    end
  end

  def log_actions(value)
    case value
    when 'destroy'
      'Eliminar'
    when 'create'
      'Crear'
    when 'update'
      'Actualizar'
    end
  end

  def estados_ac(value)
    case value
    when 0..30
      'N NORMAL'
    when 31..90
      'MORA 30+'
    when 91..120
      'MORA 90+'
    when 121..150
      'MORA 120+'
    when 151..360
      'MORA 150+'
    when 361..4116
      'CASTIGO 360+'
    end
  end

  def selectnumdiasprioridades
    [
      ['15', 15],
      ['30', 30],
      ['60', 60],
      ['90', 90],
      ['120', 120],
      ['180', 180]
    ]
  end

  def select_plazo_edu
    [
      ['2', 2],
      ['3', 3],
      ['4', 4],
      ['5', 5]
    ]
  end

  def select_sino
    [
      %w[SI SI],
      %w[NO NO]
    ]
  end

  def select_topemetodo
    [
      %w[SALDOCAPITAL SALDOCAPITAL],
      %w[SALDOTOTAL SALDOTOTAL]
    ]
  end

  def select_sinofna
    [
      %w[SI SI],
      %w[NO NO],
      ['DESISTIMIENTO TACITO', 'DESISTIMIENTO TACITO'],
      ['PROVISION', 'PROVISION']
    ]
  end

  def select_sinofna2
    [
      %w[SI SI],
      %w[NO NO],
      ['CESION DE CREDITO', 'CESION DE CREDITO']
    ]
  end

  def select_sinofna3
    [
      %w[SI SI],
      %w[NO NO],
      ['ACEPTACION DE CESION', 'ACEPTACION DE CESION'],
      ['EN TRAMITE', 'EN TRAMITE']
    ]
  end

  def select_sinofna4
    [
      %w[SI SI],
      %w[NO NO],
      ['EN TRAMITE', 'EN TRAMITE']
    ]
  end

  def select_sinofna5
    [
      %w[SI SI],
      %w[PENDIENTE PENDIENTE]
    ]
  end

  def select_tipodescuento
    [
      %w[SEMESTRE SEMESTRE],
      %w[ESTRATO ESTRATO]
    ]
  end

  def select_sinoaplica
    [
      %w[SI SI],
      %w[NO NO],
      ['NO APLICA', 'NO APLICA']
    ]
  end

  def select_fallecidodentix
    [
      %w[SI SI],
      %w[NO NO],
      ['INCAPACIDAD PERMANENTE/TOTAL', 'INCAPACIDAD PERMANENTE/TOTAL'],
      ['INSOLVENCIA', 'INSOLVENCIA']
    ]
  end

  def select_followup
    [
      %w[Completed Completed],
      ['Not signed', 'Not signed'],
      %w[Putback Putback],
      %w[Refinanced Refinanced],
      ['Waiting for debtors payment', 'Waiting for debtors payment']
    ]
  end

  def select_sinoingles
    [
      %w[YES YES],
      %w[NO NO]
    ]
  end

  def select_sinoinglesgarantia
    [
      %w[YES-PRINCIPAL YES-PRINCIPAL],
      %w[YES YES],
      %w[NO NO]
    ]
  end

  def select_match
    [
      %w[MATCH MATCH],
      ['NO MATCH', 'NO MATCH']
    ]
  end

  def select_hipoteca
    [
      %w[SI SI],
      %w[NO NO],
      ['SIN ESCRITURA', 'SIN ESCRITURA'],
      ['SIN HIPOTECA', 'SIN HIPOTECA']
    ]
  end

  def select_sinopayu
    [
      ['SI', 1],
      ['NO', 0]
    ]
  end

  def select_monedapayu
    [
      ['Peso Argentino', 'ARS'],
      ['Real Brasileño', 'BRL'],
      ['Peso Chileno', 'CLP'],
      ['Peso Colombiano', 'COP'],
      ['Peso Mexicano', 'MXN'],
      ['Nuevo Sol Peruano', 'PEN'],
      ['Dólar Americano', 'USD']
    ]
  end

  def select_no
    [
      %w[NO NO]
    ]
  end

  def select_genero
    [
      %w[MASCULINO MASCULINO],
      %w[FEMENINO FEMENINO]
    ]
  end

  def select_clasedeudor
    [
      ['DEUDOR PRINCIPAL', 'DEUDOR PRINCIPAL'],
      ['DEUDOR SOLIDARIO', 'DEUDOR SOLIDARIO']
    ]
  end


  def select_situacion_econo
    [
      %w[EMPLEADO EMPLEADO],
      %w[INDEPENDIENTE INDEPENDIENTE],
      %w[DESEMPLEADO DESEMPLEADO],
      %w[PENSIONADO PENSIONADO],
      ["ESTUDIANTE","ESTUDIANTE"],
      ['SIN DATO', 'SIN DATO']
    ]
  end

  def select_tipogecasr
    [
      %w[PERSONALIZADA PERSONALIZADA],
      %w[TELEFONICA TELEFONICA],
      %w[DOMICILIARIA DOMICILIARIA],
      ['CORREO FISICO', 'CORREO FISICO'],
      ['CORREO ELECTRONICO', 'CORREO ELECTRONICO'],
      ['PROMESA PAGO', 'PROMESA PAGO'],
      %w[OTRA OTRA]
    ]
  end

  def select_oficinaregistro
    is_select_oficinaregistro
  end

  def select_municipio
    return is_select_municipio
  end

  def select_tiposestado
    return is_select_tiposestado
  end

  def select_notaria
    is_select_notaria
  end

  def select_tipoproceso
    [
      ['EJECUTIVO SINGULAR', 'EJECUTIVO SINGULAR'],
      ['EJECUTIVO MIXTO', 'EJECUTIVO MIXTO'],
      ['EJECUTIVO HIPOTECARIO', 'EJECUTIVO HIPOTECARIO'],
      ['EJECUTIVO PRENDARIO', 'EJECUTIVO PRENDARIO']
    ]
  end

  def select_caracteristicatitulo
    [
      ['REAL CON GARANTIA HIPOTECARIA', 'REAL CON GARANTIA HIPOTECARIA'],
      ['REAL CON GARANTIA PRENDARIA', 'REAL CON GARANTIA PRENDARIA'],
      %w[QUIROGRAFARIO QUIROGRAFARIO]
    ]
  end

  def select_tipojuzgado
    [
      ['CIVIL MUNICIPAL', 'CIVIL MUNICIPAL'],
      ['CIVIL DEL CIRCUITO', 'CIVIL DEL CIRCUITO'],
      ['PROMISCUO MUNICIPAL', 'PROMISCUO MUNICIPAL'],
      ['PROMISCUO DE CIRCUITO', 'PROMISCUO DE CIRCUITO'],
      ['TRIBUNAL SUPERIOR', 'TRIBUNAL SUPERIOR'],
      ['CORTE SUPREMA', 'CORTE SUPREMA']
    ]
  end

  def select_estadoproceso
    [
      %w[ACTIVO ACTIVO],
      ['ACUERDO DE PAGO ORIGINADOR', 'ACUERDO DE PAGO ORIGINADOR'],
      %w[ADMINITIDA ADMINITIDA],
      %w[ARCHIVADO ARCHIVADO],
      ['ARCHIVO DEFINITIVO', 'ARCHIVO DEFINITIVO'],
      %w[BRP BRP],
      %w[DEVUELTA DEVUELTA],
      ['DACIÓN EN PAGO', 'DACION EN PAGO'],
      ['DEMANDA RECHAZADA', 'DEMANDA RECHAZADA'],
      ['DEMANDA INADMITIDA', 'DEMANDA INADMITIDA'],
      ['DEMANDA RETIRADA', 'DEMANDA RETIRADA'],
      ['EN TERMINACIÓN', 'EN TERMINACION'],
      ['EN TRAMITE', 'EN TRAMITE'],
      %w[INACTIVO INACTIVO],
      ['INACTIVO INCIERTO', 'INACTIVO INCIERTO'],
      %w[INADMITEN INADMITEN],
      %w[INADMITIDA INADMITIDA],
      %w[INSOLVENCIA INSOLVENCIA],
      ['PROCESO EN CONTRA', 'PROCESO EN CONTRA'],
      %w[RECHAZADA RECHAZADA],
      ['RECEPCION GARANTIAS', 'RECEPCION GARANTIAS'],
      %w[RECOMPRA RECOMPRA],
      %w[REMATADO REMATADO],
      %w[RETIRADA RETIRADA],
      ['SIN INFORMACION DEL ORIGINADOR', 'SIN INFORMACION DEL ORIGINADOR'],
      ['SIN UBICACION', 'SIN UBICACION'],
      ['SOLICITUD TERMINACION', 'SOLICITUD TERMINACION'],
      %w[SUSPENDIDO SUSPENDIDO],
      %w[SUSPENCION SUSPENCION],
      ['SUSPENCION DEL PROCESO', 'SUSPENCION DEL PROCESO'],
      %w[TERMINADO TERMINADO],
      ['TERMINADO POR JUZGADO', 'TERMINADO POR JUZGADO'],
      ['DEVOLUCION GARANTIA', 'DEVOLUCION GARANTIA'],
      ['TERMINADO POR DESISTIMIENTO TACITO', 'TERMINADO POR DESISTIMIENTO TACITO'],
      ['TERMINADO POR PAGO', 'TERMINADO POR PAGO'],
      ['TERMINADO POR PAGO TOTAL', 'TERMINADO POR PAGO TOTAL'],
      ['TERMINADO PAGO CUOTAS EN MORA', 'TERMINADO PAGO CUOTAS EN MORA'],
      ['VENTA DE DERECHOS DE CREDITO', 'VENTA DE DERECHOS DE CREDITO'],
      ['VERIFICAR ACUERDO DE PAGO', 'VERIFICAR ACUERDO DE PAGO'],
      ['VERIFICAR TERMINACION', 'VERIFICAR TERMINACION']
    ]
  end

  def select_estadodetalleproceso
    [
      %w[CLOSED CLOSED],
      %w[OPEN OPEN],
      ['MIX PERFORMING', 'MIX PERFORMING'],
      %w[PUTBACK PUTBACK]
    ]
  end

  def select_estadogca_proceso
    [
      %w[ACTIVO ACTIVO],
      %w[DEVUELTA DEVUELTA],
      ['ENTREGA A PREJURIDICO', 'ENTREGA A PREJURIDICO'],
      %w[RECOMPRA RECOMPRA],
      %w[SUSPENSION SUSPENSION],
      %w[TERMINADO TERMINADO],
      ['TRAMITE DE CESION', 'TRAMITE DE CESION'],
      ['VENTA DE DERECHOS DE CREDITO', 'VENTA DE DERECHOS DE CREDITO'],
      ['SUSPENDIDO POR TRAMITE DE INSOLVENCIA', 'SUSPENDIDO POR TRAMITE DE INSOLVENCIA']
    ]
  end

  def select_estadoconal_proceso
    [
      %w[ACTIVO ACTIVO],
      %w[DEVUELTA DEVUELTA],
      ['ENTREGA A PREJURIDICO', 'ENTREGA A PREJURIDICO'],
      %w[RECOMPRA RECOMPRA],
      ['RECHAZO DE LA DEMANDA DE PLENO', 'RECHAZO DE LA DEMANDA DE PLENO'],
      ['RECHAZO DE DEMANDA POR COMPETENCIA', 'RECHAZO DE DEMANDA POR COMPETENCIA'],
      ['RETIRO DE DEMANDA', 'RETIRO DE DEMANDA'],
      %w[SUSPENSION SUSPENSION],
      %w[TERMINADO TERMINADO],
      ['TRAMITE DE CESION', 'TRAMITE DE CESION'],
      ['VENTA DE DERECHOS DE CREDITO', 'VENTA DE DERECHOS DE CREDITO'],
      ['SUSPENDIDO POR TRAMITE DE INSOLVENCIA', 'SUSPENDIDO POR TRAMITE DE INSOLVENCIA']
    ]
  end

  def select_estadofna_proceso
    [
      %w[ACTIVO ACTIVO],
      ['ACTIVO - INSOLVENCIA', 'ACTIVO - INSOLVENCIA'],
      ['ACTIVO - LIQUIDACION PATRIMONIAL', 'ACTIVO - LIQUIDACION PATRIMONIAL'],
      ['CON CESION A TERCERO - UG', 'CON CESION A TERCERO - UG'],
      ['DEMANDA RECHAZADA - UG', 'DEMANDA RECHAZADA - UG'],
      %w[INACTIVO INACTIVO],
      %w[INSOLVENCIA INSOLVENCIA],
      ['TERMINADO POR PAGO TOTAL - UG', 'TERMINADO POR PAGO TOTAL - UG'],
      ['TERMINADO PAGO CUOTAS - UG', 'TERMINADO PAGO CUOTAS - UG'],
      ['PENDIENTE TERMINACION CONFIRMAR SOLICITUD', 'PENDIENTE TERMINACION CONFIRMAR SOLICITUD'],
      ['TERMINADO POR DESISTIMIENTO TACITO - UG', 'TERMINADO POR DESISTIMIENTO TACITO - UG'],
      ['TERMINADO POR DESISTIMIENTO TACITO', 'TERMINADO POR DESISTIMIENTO TACITO'],
      ['PENDIENTE TERMINACION INSTRUCCION A ABOGADO', 'PENDIENTE TERMINACION INSTRUCCION A ABOGADO'],
      ['PENDIENTE TERMINACION INSTRUCCION A ABOGADO - UG', 'PENDIENTE TERMINACION INSTRUCCION A ABOGADO - UG'],
      ['TERMINADO - UG', 'TERMINADO - UG'],
      ['TERMINADO INASISTENCIA AUDIENCIA - UG', 'TERMINADO INASISTENCIA AUDIENCIA - UG'],
      ['PENDIENTE TERMINACION DESPACHO RESUELVA - UG', 'PENDIENTE TERMINACION DESPACHO RESUELVA - UG'],
      ['PENDIENTE TERMINACION CONFIRMAR SOLICITUD - UG', 'PENDIENTE TERMINACION CONFIRMAR SOLICITUD - UG'],
      ['TERMINADO SENTENCIA ANTICIPADA - UG', 'TERMINADO SENTENCIA ANTICIPADA - UG'],
      ['PENDIENTE VALIDAR ACEPTACION DE CESION A TERCERO ', 'PENDIENTE VALIDAR ACEPTACION DE CESION A TERCERO'],
      ['PENDIENTE VALIDAR ACEPTACION DE CESION A TERCERO - UG', 'PENDIENTE VALIDAR ACEPTACION DE CESION A TERCERO - UG'],
      ['SUSPENDIDO - INSOLVENCIA', 'SUSPENDIDO - INSOLVENCIA'],
      ['SUSPENDIDO - LIQUIDACION PATRIMONIAL', 'SUSPENDIDO - LIQUIDACION PATRIMONIAL'],
      ['TERMINADO CARENCIA DE TITULO', 'TERMINADO CARENCIA DE TITULO'],
      ['TERMINADO EXCEPCION PRESCRIPCION', 'TERMINADO EXCEPCION PRESCRIPCION'],
      ['TERMINADO INASISTENCIA AUDIENCIA', 'TERMINADO INASISTENCIA AUDIENCIA'],
      ['TERMINADO PAGO', 'TERMINADO PAGO'],
      ['TERMINADO PAGO CUOTAS', 'TERMINADO PAGO CUOTAS'],
      ['TERMINADO POR DESISTIMIENTO TACITO - INSOLVENCIA', 'TERMINADO POR DESISTIMIENTO TACITO - INSOLVENCIA'],
      ['TERMINADO POR DESISTIMIENTO TACITO - LIQUIDACION PATRIMONIAL', 'TERMINADO POR DESISTIMIENTO TACITO - LIQUIDACION PATRIMONIAL'],
      ['TERMINADO SENTENCIA ANTICIPADA', 'TERMINADO SENTENCIA ANTICIPADA'],
      %w[DEVUELTA DEVUELTA],
      ['ENTREGA A PREJURIDICO', 'ENTREGA A PREJURIDICO'],
      %w[RECOMPRA RECOMPRA],
      %w[SUSPENSION SUSPENSION],
      %w[TERMINADO TERMINADO],
      ['TRAMITE DE CESION', 'TRAMITE DE CESION'],
      ['VENTA DE DERECHOS DE CREDITO', 'VENTA DE DERECHOS DE CREDITO'],
      ['SUSPENDIDO POR TRAMITE DE INSOLVENCIA', 'SUSPENDIDO POR TRAMITE DE INSOLVENCIA']
    ]
  end

  def select_procesosnulidad
    [
      ['DEMANDADO PRESENTA NULIDAD', 'DEMANDADO PRESENTA NULIDAD'],
      ['SE CORRE TRASLADO A NULIDAD', 'SE CORRE TRASLADO A NULIDAD'],
      ['JUEZ DECRETA NULIDAD', 'JUEZ DECRETA NULIDAD'],
      ['SE DESCORRE TRASLADO A NULIDAD', 'SE DESCORRE TRASLADO A NULIDAD'],
      ['REVOCA NULIDAD', 'REVOCA NULIDAD'],
      ['NO TIENE EN CUENTA NULIDAD', 'NO TIENE EN CUENTA NULIDAD']
    ]
  end

  def select_procesosnulidad
    [
      ['DEMANDADO PRESENTA NULIDAD', 'DEMANDADO PRESENTA NULIDAD'],
      ['SE CORRE TRASLADO A NULIDAD', 'SE CORRE TRASLADO A NULIDAD'],
      ['JUEZ DECRETA NULIDAD', 'JUEZ DECRETA NULIDAD'],
      ['SE DESCORRE TRASLADO A NULIDAD', 'SE DESCORRE TRASLADO A NULIDAD'],
      ['REVOCA NULIDAD', 'REVOCA NULIDAD'],
      ['NO TIENE EN CUENTA NULIDAD', 'NO TIENE EN CUENTA NULIDAD']
    ]
  end

  def select_procesosrecursos
    [
      ['RECURSO DE APELACION', 'RECURSO DE APELACION'],
      ['RECURSO DE QUEJA', 'RECURSO DE QUEJA'],
      ['RECURSO DE REPOSICION', 'RECURSO DE REPOSICION'],
      ['RECURSO DE REPOSICIÓN EN SUBSIDIO DE APELACIÓN', 'RECURSO DE REPOSICIÓN EN SUBSIDIO DE APELACIÓN'],
      ['SE SUSTENTA RECURSO', 'SE SUSTENTA RECURSO'],
      ['SE DECLARA DESIERTO EL RECURSO', 'SE DECLARA DESIERTO EL RECURSO'],
      ['SE DA TRASLADO AL SUPERIOR JERARQUICO', 'SE DA TRASLADO AL SUPERIOR JERARQUICO'],
      ['SUPERIOR JERARQUICO REVOCA DECISION DE PRIMERA INSTANCIA', 'SUPERIOR JERARQUICO REVOCA DECISION DE PRIMERA INSTANCIA'],
      ['SUPERIOR JERARQUICO CONFIRMA DECISION DE PRIMERA INSTANCIA', 'SUPERIOR JERARQUICO CONFIRMA DECISION DE PRIMERA INSTANCIA']
    ]
  end

  def select_procesosreconocimiento
    [
      ['RECONOCE PERSONERIA', 'RECONOCE PERSONERIA'],
      ['RECHAZA RECONOCIMIENTO', 'RECHAZA RECONOCIMIENTO'],
      ['REQUIERE DOCUMENTACION PARA RECONOCIMIENTO', 'REQUIERE DOCUMENTACION PARA RECONOCIMIENTO'],
      ['RENUNCIA APODERADO JUDICIAL', 'RENUNCIA APODERADO JUDICIAL'],
      ['SOLICITUD', 'SOLICITUD']
    ]
  end

  def select_estadocodensa_proceso
    [
      %w[ACTIVO ACTIVO],
      ['DEMANDA RADICADA', 'DEMANDA RADICADA'],
      %w[DEVUELTA DEVUELTA],
      ['ENTRADA', 'ENTRADA'],
      ['ENTREGA A PREJURIDICO', 'ENTREGA A PREJURIDICO'],
      %w[RECOMPRA RECOMPRA],
      ['SALIDA', 'SALIDA'],
      %w[SUSPENSION SUSPENSION],
      %w[TERMINADO TERMINADO],
      ['TRAMITE DE CESION', 'TRAMITE DE CESION'],
      ['VENTA DE DERECHOS DE CREDITO', 'VENTA DE DERECHOS DE CREDITO'],
      ['SUSPENDIDO POR TRAMITE DE INSOLVENCIA', 'SUSPENDIDO POR TRAMITE DE INSOLVENCIA']
    ]
  end

  def select_estadocongelacion
    [
      ['NO CONGELADO', 'NO CONGELADO'],
      ['SI CONGELADO', 'SI CONGELADO'],
      ['CASTIGADA', 'CASTIGADA'],
      ['N/A', 'N/A']
    ]
  end

  def select_medidacautelarcodensa
    [
      ['EMBARGO', 'EMBARGO'],
      ['PENDIENTE POR DECRETARSE', 'PENDIENTE POR DECRETARSE'],
      ['DECRETADO', 'DECRETADO'],
      ['SIN MEDIDAS CAUTELARES', 'SIN MEDIDAS CAUTELARES'],
      ['REGISTRADO', 'REGISTRADO']
    ]
  end

  def select_embargocodensa
    [
      ['S', 'S'],
      ['N', 'N']
    ]
  end

  def select_medida_cautelar_solicitada
    [
      ['BIEN INMUEBLE', 'BIEN INMUEBLE'],
      ['BIEN INMUEBLE Y CUENTAS BANCARIAS', 'BIEN INMUEBLE Y CUENTAS BANCARIAS'],
      ['CUENTAS BANCARIAS', 'CUENTAS BANCARIAS'],
      ['CUENTAS BANCARIAS Y ESTABLECIMIENTO DE COMERCIO', 'CUENTAS BANCARIAS Y ESTABLECIMIENTO DE COMERCIO'],
      ['CUOTA PARTE', 'CUOTA PARTE'],
      ['CUOTA PARTE Y CUENTAS BANCARIAS', 'CUOTA PARTE Y CUENTAS BANCARIAS'],
      ['INMUEBLE', 'INMUEBLE'],
      ['PENDIENTE', 'PENDIENTE'],
      ['REMANENTES', 'REMANENTES'],
      ['REMANENTES Y CUENTAS BANCARIAS', 'REMANENTES Y CUENTAS BANCARIAS'],
      ['SIN MEDIDAS CAUTELARES', 'SIN MEDIDAS CAUTELARES'],
      ['SOBRE BIEN INMUEBLE', 'SOBRE BIEN INMUEBLE']
    ]
  end

  def select_user
    is_select_user
  end

  def select_useractivo
    is_select_useractivo
  end

  def select_useredupol
    is_select_useredupol
  end

  def select_parorigenespago
    is_select_parorigenespago
  end

  def select_tipodocumento
    is_select_tipodocumento
  end

  def select_tipopersona
    [
      ['PERSONA NATURAL', 'PERSONA NATURAL'],
      ['PERSONA JURIDICA', 'PERSONA JURIDICA']
    ]
  end

  def select_estadocivil
    [
      %w[CASADO CASADO],
      %w[DIVORCIADO DIVORCIADO],
      %w[ND ND],
      ['Q.E.P.D.', 'Q.E.P.D.'],
      %w[SEPARADO SEPARADO],
      %w[SOLTERO SOLTERO],
      ['UNION LIBRE', 'UNION LIBRE'],
      %w[VIUDO VIUDO]
    ]
  end

  def select_cliente
    is_select_cliente
  end

  def select_partiposcartera
    is_select_partiposcartera
  end

  def select_lineacredito
    is_select_lineacredito
  end

  def select_partiposproducto
    is_select_partiposproducto
  end

  def select_canal
    [
      ['ALMACENES CADENA', 'ALMACENES CADENA'],
      %w[BALOTTO BALOTTO],
      ['BOTON DE PAGOS', 'BOTON DE PAGOS'],
      %w[OFICINA OFICINA],
      %w[TRANSFERENCIA TRANSFERENCIA],
      %w[CONSIGNACION CONSIGNACION]
    ]
  end

  def select_entidad
    [
      %w[BANCOLOMBIA BANCOLOMBIA],
      %w[BBVA BBVA],
      %w[CITIBANK CITIBANK],
      %w[DAVIVIENDA DAVIVIENDA],
      %w[FCPII FCPII],
      ['BANCO CAJA SOCIAL', 'BANCO CAJA SOCIAL'],
      ['BANCO AGRARIO', 'BANCO AGRARIO'],
      ['BANCO AV VILLAS', 'BANCO AV VILLAS'],
      ['BANCO COLPATRIA', 'BANCO COLPATRIA'],
      ['BANCO PICHINCHA', 'BANCO PICHINCHA'],
      ['CREDYTY', 'CREDYTY'],
      ['BALOTO', 'BALOTO'],
      ['FINSOCIAL', 'FINSOCIAL'],
      ['BANCO POPULAR', 'BANCO POPULAR'],
      ['BANCO DE BOGOTA', 'BANCO DE BOGOTA'],
      ['VISA', 'VISA'],
      ['MASTER CARD', 'MASTER CARD'],
      %w[CONFIAR CONFIAR],
      ['BANCO DE OCCIDENTE', 'BANCO DE OCCIDENTE'],
      %w[FIDUCENTRAL FIDUCENTRAL],
      %w[PSE PSE],
      ['ICETEX', 'ICETEX'],
      ['CESANTIAS', 'CESANTIAS']
    ]
  end

  def select_tipoliquidacion
    [
      ['PIN', 10082],
      ['INSCRIPCIÓN', 10083]
    ]
  end

  def select_modelo
    [
      ['CUOTA CONSTANTE', 'CUOTA CONSTANTE'],
      ['ABONO CONSTANTE CAPITAL CON INTERESES', 'ABONO CONSTANTE CAPITAL CON INTERESES'],
      ['PLAN DE PAGOS FLEXIBLE', 'PLAN DE PAGOS FLEXIBLE']
    ]
  end

  def select_tipo_afecta
    [
      ['AJUSTE CUOTA', 'AJUSTE CUOTA'],
      ['AJUSTE PLAZO', 'AJUSTE PLAZO']
    ]
  end

  def select_tipo_afectaajuste
    [
      ['AJUSTE CUOTA', 'AJUSTE CUOTA'],
      ['AJUSTE PLAZO', 'AJUSTE PLAZO'],
      ['AJUSTE', 'AJUSTE AUTOMATICO']
    ]
  end

  def select_tipo_resoljud
    [
      %w[ACUERDO ACUERDO],
      %w[CANCELACION CANCELACION],
      %w[REMATE REMATE]
    ]
  end

  def select_tipo_obsresoljud
    [
      ['RETRASO POR JUEZ', 'RETRASO POR JUEZ'],
      ['RETRASO POR TASADOR', 'RETRASO POR TASADOR'],
      ['RETRASO MARTILLEROS', 'RETRASO MARTILLEROS'],
      ['RETRASO UBICACION DE PARTES', 'RETRASO UBICACION DE PARTES'],
      ['DEUDOR LITIGANTE', 'DEUDOR LITIGANTE'],
      ['PROCESO COMPLEJO', 'PROCESO COMPLEJO'],
      %w[OTROS OTROS]
    ]
  end

  def select_tipo_accion
    [
      ['IMPULSO PROCESAL', 'IMPULSO PROCESAL'],
      ['CONTACTO AL CLIENTE', 'CONTACTO AL CLIENTE']
    ]
  end

  def select_tipo_afectafit
    [
      ['PAGO NORMAL', 'PAGO NORMAL'],
      %w[AMORTIZACION AMORTIZACION]
    ]
  end

  def select_tipopago
    [
      %w[EFECTIVO EFECTIVO]
    ]
  end

  def select_tipopagofit
    [
      %w[EFECTIVO EFECTIVO],
      %w[CHEQUE CHEQUE],
      %w[CONSIGNACION CONSIGNACION],
      ['DEBITO AUTOMATICO', 'DEBITO AUTOMATICO']
    ]
  end

  def select_tipopagosistem
    [
      %w[EFECTIVO EFECTIVO],
      %w[CHEQUE CHEQUE],
      ['DACIÓN EN PAGO', 'DACION EN PAGO'],
      %w[REMATE REMATE],
      ['VENTA DE DERECHOS', 'VENTA DE DERECHOS'],
      %w[RECOMPRA RECOMPRA],
      %w[SUSTITUCIÓN SUSTITUCION],
      %w[SEGUROS SEGUROS],
      ['TRASLADO DEL ORIGINADOR', 'TRASLADO DEL ORIGINADOR'],
      ['TÍTULO JUDICIAL CXC', 'TITULO JUDICIAL CXC'],
      ['TÍTULO JUDICIAL BANCO', 'TITULO JUDICIAL BANCO'],
      ['HONORARIOS DE ABOGADO', 'HONORARIOS DE ABOGADO']
    ]
  end

  def select_tipopagokfg
    [
      %w[EFECTIVO EFECTIVO],
      %w[CHEQUE CHEQUE]
    ]
  end

  def select_tipopagogps
    [
      %w[EFECTIVO EFECTIVO],
      %w[CHEQUE CHEQUE],
      ['ADJUDICADO ACREEDOR', 'ADJUDICADO ACREEDOR'],
      ['ADJUDICADO TERCERO', 'ADJUDICADO TERCERO'],
      ['ADJUDICADO CREDITO', 'ADJUDICADO CREDITO']
    ]
  end

  def select_cuenta
    is_select_cuenta
  end

  def select_clasepago
    [
      %w[ABONO ABONO],
      ['PAGO TOTAL', 'PAGO TOTAL'],
      ['NO APLICA', 'NO APLICA']
    ]
  end

  def select_formapago
    [
      %w[EFECTIVO EFECTIVO],
      %w[CONSIGNACION CONSIGNACION],
      %w[TRANSFERENCIA TRANSFERENCIA],
      %w[CHEQUE CHEQUE]
    ]
  end

  def select_claseagenda

    if is_portafolio.to_i == 10019
      [["RECORDATORIO DE PAGO", "RECORDATORIO DE PAGO"], ["POSIBLE NEGOCIACION", "POSIBLE NEGOCIACION"]]
    else
      [
        %w[AUDIENCIAS AUDIENCIAS],
        ['PASO A INSTANCIA JURIDICA', 'PASO A INSTANCIA JURIDICA'],
        ['RECORDACION DE LLAMADA', 'RECORDACION DE LLAMADA'],
        ['VERIFICACION DE PAGO', 'VERIFICACION DE PAGO'],
        ['VENCIMIENTO DE TERMINOS', 'VENCIMIENTO DE TERMINOS'],
        ['VISITA DOMICILIARIA', 'VISITA DOMICILIARIA'],
        ['VISITA A SITIO LABORAL', 'VISITA A SITIO LABORAL'],
        ['AGENDAR VISITA AL INMUEBLE', 'AGENDAR VISITA AL INMUEBLE'],
        ['LLAMADA GESTION COMERCIAL', 'LLAMADA GESTION COMERCIAL']

      ]
    end
  end

  def select_diashabilitados
    [
      ['1', 1],
      ['2', 2],
      ['3', 3],
      ['4', 4],
      ['5', 5],
      ['6', 6],
      ['7', 7],
      ['8', 8],
      ['9', 9],
      ['10', 10],
      ['11', 11],
      ['12', 12],
      ['13', 13],
      ['14', 14],
      ['15', 15],
      ['16', 16],
      ['17', 17],
      ['18', 18],
      ['19', 19],
      ['20', 20],
      ['21', 21],
      ['22', 22],
      ['23', 23],
      ['24', 24],
      ['25', 25],
      ['26', 26],
      ['27', 27],
      ['28', 28],
      ['29', 29],
      ['30', 30]
    ]
  end

  def select_pagaduria
    is_select_pagaduria
  end

  def select_cooperativa
    is_select_cooperativa
  end

  def select_inversionista
    is_select_inversionista
  end

  def select_estadopagaduria
    [
      ['FALLECIMIENTO DEUDOR', 'FALLECIMIENTO DEUDOR'],
      ['EMBARGO SALARIAL CON PRELACIÓN LEGAL', 'EMBARGO SALARIAL CON PRELACIÓN LEGAL'],
      ['DEUDOR DESVINCULADO LABORALMENTE', 'DEUDOR DESVINCULADO LABORALMENTE'],
      ['EMPRESA PAGADURÍA ILIQUIDA', 'EMPRESA PAGADURÍA ILIQUIDA'],
      ['EMPRESA PAGADURÍA EN PROCESO LIQUIDATORIO', 'EMPRESA PAGADURÍA EN PROCESO LIQUIDATORIO']
    ]
  end

  def select_tipogestioncovinoc
    [
      ['SIN GESTION', 'SIN GESTION'],
      %w[DIRECTO DIRECTO],
      %w[INDIRECTO INDIRECTO],
      %w[ILOCALIZADO ILOCALIZADO],
      ['NO CONTACTADO', 'NO CONTACTADO'],
      %w[OTROS OTROS]
    ]
  end

  def select_tipogestioncovinocgps
    [
      %w[DIRECTO DIRECTO],
      %w[INDIRECTO INDIRECTO],
      ['NO CONTACTADO', 'NO CONTACTADO']
    ]
  end

  def select_razonespago
    is_select_razonespago
  end

  def select_tipodeudor
    [
      %w[DEUDOR DEUDOR],
      %w[CODEUDOR CODEUDOR]
    ]
  end

  def select_modelog
    [
      ['PLAN DE PAGOS FLEXIBLE', 'PLAN DE PAGOS FLEXIBLE']
    ]
  end

  ######################  Andres 20160909 ###########
  def select_originador
    is_select_originador
  end

  def select_rango
    [
      ['Menos de 1.000.000', '0 and 1000000'],
      ['1.000.001 a 3.000.000', '1000001 and 3000000'],
      ['3.000.001 a 5.000.000', '3000001 and 5000000'],
      ['5.000.001 a 10.000.000', '5000001 and 10000000'],
      ['10.000.001 a 20.000.000', '10000001 and 20000000'],
      ['20.000.001 a 50.000.000', '20000001 and 50000000'],
      ['50.000.001 a 100.000.000', '50000001 and 100000000'],
      ['Mayor de 100.000.000', '100000001 and 1000000000']
    ]
  end

  def select_rangotele
    [
      ['Menos de 50.000', '0 and 50000'],
      ['50.001 a 100.000', '50001 and 100000'],
      ['100.001 a 150.000', '100001 and 150000'],
      ['150.001 a 200.000', '150001 and 200000'],
      ['200.001 a 300.000', '200001 and 300000'],
      ['300.001 a 500.000', '300001 and 500000'],
      ['500.001 a 750.000', '500001 and 750000'],
      ['750.001 a 1.000.000', '750001 and 1000000'],
      ['1.000.001 a 3.000.000', '1000001 and 3000000'],
      ['3.000.001 a 5.000.000', '3000001 and 5000000'],
      ['5.000.001 a 10.000.000', '5000001 and 10000000'],
      ['10.000.001 a 20.000.000', '10000001 and 20000000'],
      ['20.000.001 a 50.000.000', '20000001 and 50000000'],
      ['50.000.001 a 100.000.000', '50000001 and 100000000'],
      ['Mayor de 100.000.000', '100000001 and 10000000000']
    ]
  end

  def select_rangocisa
    [
      ['Menor o igual a 300.000', '0 and 300000'],
      ['300.001 a 1.000.000', '300001 and 1000000'],
      ['1.000.001 a 5.000.000', '1000001 and 5000000'],
      ['5.000.001 a 10.000.000', '5000001 and 10000000'],
      ['Mas de 10.000.000', '10000001 and 100000000']
    ]
  end

  def select_estadosdecision
    [
      %w[APROBADO APROBAR],
      %w[PENDIENTE PENDIENTE],
      %w[RECHAZADO RECHAZAR],
      %w[RECOMENDADO RECOMENDAR]
    ]
  end

  def select_estadosdecision2
    [
      %w[APROBADO APROBAR],
      %w[RECHAZADO RECHAZAR]
    ]
  end

  def select_estadosdecisionprimera
    [
      %w[RECHAZADO RECHAZAR],
      %w[RECOMENDADO RECOMENDAR]
    ]
  end

  def select_rangousd
    [
      ['Menos de 500', '0 and 500'],
      ['501 a 1.000', '501 and 1000'],
      ['1.001 a 3.000', '1001 and 3000'],
      ['3.001 a 5.000', '3001 and 5000'],
      ['5.001 a 10.000', '5001 and 10000'],
      ['10.001 a 20.000', '10001 and 20000'],
      ['20.001 a 50.000', '20001 and 50000'],
      ['Mayor de 50.000', '50001 and 2000000000']
    ]
  end

  def select_rangoper
    [
      ['Menos de 1.500', '0 and 1500'],
      ['1.501 a 3.000', '1501 and 3000'],
      ['3.001 a 15.000', '3001 and 15000'],
      ['15.001 a 30.000', '15001 and 30000'],
      ['30.001 a 60.000', '30001 and 60000'],
      ['60.001 a 150.000', '60001 and 150000'],
      ['150.001 a 300.000', '150001 and 300000'],
      ['Mayor de 300.000', '300001 and 1000000000']
    ]
  end

  def select_fechapagos
    [
      ['1 Mes', '30'],
      ['2 Meses', '60'],
      ['3 Meses', '90'],
      ['4 Meses', '120'],
      ['5 Meses', '150'],
      ['6 Meses', '180'],
      ['7 Meses', '210'],
      ['8 Meses', '240'],
      ['9 Meses', '270'],
      ['10 Meses', '300'],
      ['11 Meses', '330'],
      ['12 Meses', '360']
    ]
  end

  def select_tipogarantia
    [
      %w[PERSONAL PERSONAL],
      ['REGISTRO HIPOTECA', 'REGISTRO HIPOTECA'],
      ['REGISTRO PREDIAL', 'REGISTRO PREDIAL'],
      ['SIN GARANTIA', 'SIN GARANTIA']
    ]
  end

  def select_sinocorto
    [
      %w[SI S],
      %w[NO N]
    ]
  end

  def select_sn_users
    [
      %w[SI S],
      %w[NO N]
    ]
  end

  def select_tipoconsulta
    [
      %w[ABOGADO ABOGADO],
      %w[ANALISTA ANALISTA],
      ['CARTERA ADMINISTRADA', 'CARTERA ADMINISTRADA'],
      ['CARTERA PROPIA', 'CARTERA PROPIA'],
      %w[CENTROAPOYO CENTROAPOYO],
      %w[COMERCIAL COMERCIAL],
      %w[DIRECTOR DIRECTOR],
      %w[EDUPOLESPECIAL EDUPOLESPECIAL],
      %w[ESTUDIANTE ESTUDIANTE],
      %w[FUNCIONARIO FUNCIONARIO],
      %w[ORIGINADOR ORIGINADOR],
      %w[PORTAFOLIO PORTAFOLIO],
      %w[SUCURSAL SUCURSAL],
      %w[TECNICO TECNICO],
      %w[TODO TODO],
      %w[UNIVERSIDAD UNIVERSIDAD],
      %w[VEHICULO VEHICULO],
      ['DEMANDANTE', 'DEMANDANTE']
    ]
  end

  def select_tipoconsultaexp
    [
      %w[ABOGADO ABOGADO],
      %w[ANALISTA ANALISTA],
      ['CARTERA ADMINISTRADA', 'CARTERA ADMINISTRADA'],
      ['CARTERA PROPIA', 'CARTERA PROPIA'],
      %w[CENTROAPOYO CENTROAPOYO],
      %w[COMERCIAL COMERCIAL],
      %w[DIRECTOR DIRECTOR],
      %w[EXPERIENCIAESPECIAL EXPERIENCIAESPECIAL],
      %w[ESTUDIANTE ESTUDIANTE],
      %w[FUNCIONARIO FUNCIONARIO],
      %w[ORIGINADOR ORIGINADOR],
      %w[PORTAFOLIO PORTAFOLIO],
      %w[SUCURSAL SUCURSAL],
      %w[TECNICO TECNICO],
      %w[TODO TODO],
      %w[UNIVERSIDAD UNIVERSIDAD],
      %w[VEHICULO VEHICULO],
      ['DEMANDANTE', 'DEMANDANTE']
    ]
  end

  def select_estado
    [
      %w[ACTIVO ACTIVO],
      %w[INACTIVO INACTIVO]
    ]
  end

  def select_estado_datacredito
    [
      %w[ACTIVO ACTIVO],
      %w[INACTIVO INACTIVO]
    ]
  end

  def select_estado_ac
    [
      %w[ACTIVO ACTIVO],
      %w[INACTIVO INACTIVO]
    ]
  end

  def select_categoria_documentos
    [
      %w[SOCIOECONÓMICOS SOCIOECONÓMICOS],
      %w[ACADÉMICOS ACADÉMICOS],
      %w[FINANCIEROS FINANCIEROS]
    ]
  end

  def select_estado_portafolios
    [
      %w[ACTIVO ACTIVO],
      %w[INACTIVO INACTIVO]
    ]
  end

  def select_estadoestudiante
    [
      ['ACTIVO', 'ACTIVO'],
      ['PENDIENTE POR ACTIVAR', 'PENDIENTE POR ACTIVAR'],
      ['EN PROCESO', 'EN PROCESO'],
      ['INACTIVO', 'INACTIVO'],
      ['RETIRO FINANCIERO', 'RETIRO FINANCIERO'],
      ['RETIRO ACADEMICO', 'RETIRO ACADEMICO'],
      ['FALLECIDO', 'FALLECIDO'],
      ['RETIRO - R.E', 'RETIRO - R.E'],
      ['RETIRO - R. E. Con pago', 'RETIRO - R. E. Con pago'],
      ['RETIRO - R. E. Sin pago', 'RETIRO - R. E. Sin pago'],
      ["PAGÓ EN IES", "PAGO EN IES"]
    ]
  end

  def select_estadoestudianteexp
    [
      ['ACTIVO', 'ACTIVO'],
      ['PENDIENTE POR ACTIVAR', 'PENDIENTE POR ACTIVAR'],
      ['EN PROCESO', 'EN PROCESO'],
      ['INACTIVO', 'INACTIVO'],
      ['RETIRO FINANCIERO', 'RETIRO FINANCIERO'],
      ['RETIRO ACADEMICO', 'RETIRO ACADEMICO'],
      ['GRADUADO', 'GRADUADO'],
      ['FALLECIDO', 'FALLECIDO'],
      ['APLAZAMIENTO', 'APLAZAMIENTO'],
      ['ADOPTADO', 'ADOPTADO'],
      ['ESTUDIANTE PERDIDO', 'ESTUDIANTE PERDIDO']
    ]
  end

  def select_estadoestudiante2
    [
      %w[ACTIVO ACTIVO],
      %w[INACTIVO INACTIVO]
    ]
  end

  def select_tiponovacion
    [
      ['ACUERDO DE PAGO CONTADO', 'ACUERDO DE PAGO CONTADO'],
      ['ACUERDO DE PAGO PLAZO', 'ACUERDO DE PAGO PLAZO'],
      %w[NOVACION NOVACION]
    ]
  end

  def select_estadonovacion
    [
      %w[PENDIENTE PENDIENTE],
      %w[INCUMPLIDO INCUMPLIDO],
      ['EN MORA', 'EN MORA'],
      ['AL DIA', 'AL DIA'],
      ['NO VIGENTE', 'NO VIGENTE'],
      %w[CUMPLIDO CUMPLIDO]
    ]
  end

  def select_unidad_denominacion
    [
      %w[DOLARES USD],
      %w[SOLES SOLES],
      %w[EUROS EUROS]
    ]
  end

  def select_unidad_denominacioncuenta
    [
      %w[DOLARES USD],
      %w[SOLES SOLES],
      %w[EUROS EUROS],
      %w[PESOS COP],
      %w[LEMPIRA HNL]
    ]
  end

  def select_unidad_denominacion_gps
    [
      %w[DOLARES USD],
      %w[SOLES SOLES]
    ]
  end

  def select_unidad_denominacion_gps2
    [
      %w[DOLARES USD],
      %w[SOLES PEN]
    ]
  end

  def select_unidad_denominacion_gpspen
    [
      %w[USD USD],
      %w[PEN PEN]
    ]
  end

  def select_mes
    [
      ['', ''],
      %w[ENERO 01],
      %w[FEBRERO 02],
      %w[MARZO 03],
      %w[ABRIL 04],
      %w[MAYO 05],
      %w[JUNIO 06],
      %w[JULIO 07],
      %w[AGOSTO 08],
      %w[SEPTIEMBRE 09],
      %w[OCTUBRE 10],
      %w[NOVIEMBRE 11],
      %w[DICIEMBRE 12]
    ]
  end

  def select_anno
    [
      %w[2012 2012],
      %w[2013 2013],
      %w[2014 2014],
      %w[2015 2015],
      %w[2016 2016],
      %w[2017 2017],
      %w[2018 2018],
      %w[2019 2019],
      %w[2020 2020],
      %w[2021 2021],
      %w[2022 2022],
      %w[2023 2023]
    ]
  end

  def select_messystem
    is_select_messystem
  end

  def select_annosystem
    is_select_annosystem
  end

  def select_mes
    [
      %w[ENERO 01],
      %w[FEBRERO 02],
      %w[MARZO 03],
      %w[ABRIL 04],
      %w[MAYO 05],
      %w[JUNIO 06],
      %w[JULIO 07],
      %w[AGOSTO 08],
      %w[SEPTIEMBRE 09],
      %w[OCTUBRE 10],
      %w[NOVIEMBRE 11],
      %w[DICIEMBRE 12]
    ]
  end

  def select_mesedu
    [
      %w[DICIEMBRE 12]
    ]
  end

  def select_annoedu
    [
      %w[2018 2018]
    ]
  end

  def select_anno2
    [
      %w[2016 2016],
      %w[2017 2017],
      %w[2018 2018],
      %w[2019 2019],
      %w[2020 2020],
      %w[2021 2021],
      %w[2022 2022],
      %w[2023 2023]
    ]
  end

  def select_anno4
    [
      %w[2022 2022],
      %w[2021 2021],
      %w[2020 2020],
      %w[2019 2019],
      %w[2018 2018],
      %w[2017 2017],
      %w[2016 2016],
      %w[2015 2015],
      %w[2014 2014],
      %w[2013 2013]
    ]
  end

  def select_annorenta
    [
      %w[2022 2022],
      %w[2021 2021],
      %w[2020 2020],
      %w[2019 2019],
      %w[2018 2018],
      %w[2017 2017],
      %w[2016 2016],
      %w[2015 2015],
      %w[2014 2014],
      %w[2013 2013]
    ]
  end

  def select_annorentafna
    [
      %w[2021 2021],
      %w[2020 2020],
      %w[2019 2019],
      %w[2018 2018]
    ]
  end

  def select_anno3
    [
      %w[2019 2019],
      %w[2018 2018],
      %w[2017 2017],
      %w[2016 2016],
      %w[2015 2015],
      %w[2014 2014],
      %w[2013 2013]
    ]
  end

  def select_nivel
    [
      ['GESTION', 1],
      ['CARGUES', 6],
      ['PROCESOS', 2],
      ['PARAMETRIZACIÓN', 3],
      ['SEGURIDAD', 4],
      ['PARAMETRIZACIÓN EDUCACIÓN', 5],
      ['MENU PORTAFOLIO', 7],
      ['MENU PERSONAS', 8],
      ['PARAMETRIZACIÓN SAE', 9]
    ]
  end

  def select_tiporecaudo
    [
      ['HONORARIOS DE ABOGADO', 'HONORARIOS DE ABOGADO'],
      ['GASTOS JUDICIALES', 'GASTOS JUDICIALES'],
      ['PAZ Y SALVO', 'PAZ Y SALVO'],
      %w[OTROS OTROS]
    ]
  end

  def select_otrostiporecaudo
    [
      ['HONORARIOS DE ABOGADO', 'HONORARIOS DE ABOGADO'],
      ['GASTOS JUDICIALES', 'GASTOS JUDICIALES'],
      ['PAZ Y SALVO', 'PAZ Y SALVO'],
      ['CARTA DE NO ADEUDO', 'CARTA DE NO ADEUDO'],
      ['CARTA DE NO ADEUDO DUPLICADO', 'CARTA DE NO ADEUDO DUPLICADO'],
      %w[OTROS OTROS]
    ]
  end

  def select_tiporeq
    [
      ['NUEVO DESARROLLO', 'NUEVO DESARROLLO'],
      ['INCONSISTENCIA EN NORMALIZACION', 'INCONSISTENCIA EN NORMALIZACION'],
      ['INCONSISTENCIA EN RECAUDOS', 'INCONSISTENCIA EN RECAUDOS'],
      ['INCONSISTENCIA EN GESTIONES', 'INCONSISTENCIA EN GESTIONES'],
      ['INCONSISTENCIA EN NOVACIONES', 'INCONSISTENCIA EN NOVACIONES'],
      ['INCONSISTENCIA EN PERSONAS', 'INCONSISTENCIA EN PERSONAS'],
      ['INCONSISTENCIA EN ASIGNACIONES', 'INCONSISTENCIA EN ASIGNACIONES'],
      ['INCONSISTENCIA EN REPORTES', 'INCONSISTENCIA EN REPORTES'],
      ['INCONSISTENCIA EN OBLIGACION', 'INCONSISTENCIA EN OBLIGACION'],
      %w[MEJORA MEJORA],
      ['CREACION DE USUARIOS', 'CREACION DE USUARIOS'],
      %w[SOPORTES SOPORTES]
    ]
  end

  def select_prioridad
    [
      %w[EXTREMO EXTREMO],
      %w[ALTA ALTA],
      %w[MEDIA MEDIA],
      %w[BAJA BAJA]
    ]
  end

  def select_calificacion_soporte2
    [
      ['3', 3],
      ['2', 2],
      ['1', 1]
    ]
  end

  def select_portafolioscuenta
    is_select_portafolioscuenta
  end

  def select_sucursal(portafolioid)
    is_select_sucursal(portafolioid)
  end

  def nombresucursal(value)
    Portafoliossucursal.select(:descripcion).find(value)
  end

  def select_niveleducativo
    [
      %w[TECNICO TECNICO],
      %w[TECNOLOGICO TECNOLOGICO],
      %w[UNIVERSITARIO UNIVERSITARIO],
      %w[POSGRADO POSGRADO]
    ]
  end

  def select_periodicidad
    [
      %w[SEMESTRAL SEMESTRAL],
      %w[ANUAL ANUAL]
    ]
  end

  def select_semestreedu
    [
      ['SEMESTRE 1', 'SEMESTRE 1'],
      ['SEMESTRE 2', 'SEMESTRE 2'],
      ['SEMESTRE 3', 'SEMESTRE 3'],
      ['SEMESTRE 4', 'SEMESTRE 4'],
      ['SEMESTRE 5', 'SEMESTRE 5'],
      ['SEMESTRE 6', 'SEMESTRE 6'],
      ['SEMESTRE 7', 'SEMESTRE 7'],
      ['SEMESTRE 8', 'SEMESTRE 8'],
      ['SEMESTRE 9', 'SEMESTRE 9'],
      ['SEMESTRE 10', 'SEMESTRE 10']
    ]
  end

  def select_semestre
    [
      %w[2007-1 2007-1],
      %w[2007-2 2007-2],
      %w[2008-1 2008-1],
      %w[2008-2 2008-2],
      %w[2009-1 2009-1],
      %w[2009-2 2009-2],
      %w[2010-1 2010-1],
      %w[2010-2 2010-2],
      %w[2011-1 2011-1],
      %w[2011-2 2011-2],
      %w[2012-1 2012-1],
      %w[2012-2 2012-2],
      %w[2013-1 2013-1],
      %w[2013-2 2013-2],
      %w[2014-1 2014-1],
      %w[2014-2 2014-2],
      %w[2015-1 2015-1],
      %w[2015-2 2015-2],
      %w[2016-1 2016-1],
      %w[2016-2 2016-2],
      %w[2017-1 2017-1],
      %w[2017-2 2017-2]
    ]
  end

  def select_motivonofinalizo
    [
      ['FINALIZACIÓN DEL PROGRAMA ACADÉMICO', 'FINALIZACIÓN DEL PROGRAMA ACADÉMICO'],
      ['LIMITE DE SUSPENSIONES TEMPORALES', 'LIMITE DE SUSPENSIONES TEMPORALES'],
      ['ABANDONO INJUSTIFICADO DEL PROGRAMA', 'ABANDONO INJUSTIFICADO DEL PROGRAMA'],
      %w[OTRO OTRO]
    ]
  end

  def select_rangocalendar
    [2017, 2018]
  end

  def select_userhora
    [
      ['07:00 a.m.', '07:00:00'],
      ['07:30 a.m.', '07:30:00'],
      ['08:00 a.m.', '08:00:00'],
      ['08:30 a.m.', '08:30:00'],
      ['09:00 a.m.', '09:00:00'],
      ['09:30 a.m.', '09:30:00'],
      ['10:00 a.m.', '10:00:00'],
      ['10:30 a.m.', '10:30:00'],
      ['11:00 a.m.', '11:00:00'],
      ['11:30 a.m.', '11:30:00'],
      ['12:00 p.m.', '12:00:00'],
      ['12:30 p.m.', '12:30:00'],
      ['01:00 p.m.', '13:00:00'],
      ['01:30 p.m.', '13:30:00'],
      ['02:00 p.m.', '14:00:00'],
      ['02:30 p.m.', '14:30:00'],
      ['03:00 p.m.', '15:00:00'],
      ['03:30 p.m.', '15:30:00'],
      ['04:00 p.m.', '16:00:00'],
      ['04:30 p.m.', '16:30:00'],
      ['05:00 p.m.', '17:00:00'],
      ['05:30 p.m.', '17:30:00'],
      ['06:00 p.m.', '18:00:00'],
      ['06:30 p.m.', '18:30:00'],
      ['07:00 p.m.', '19:00:00']
    ]
  end

  def select_userpersonal
    [
      ['1', 1],
      ['2', 2],
      ['3', 3],
      ['4', 4],
      ['5', 5],
      ['6', 6],
      ['7', 7],
      ['8', 8]
    ]
  end

  def select_tasas2gca
    is_select_tasas2gca
    #     [
    #       ["Quirografaria","1"],
    #       ["Un codeudor laborando","2"],
    #       ["Dos codeudores laborando ó un codeudor con finca raiz","3"],
    #       ["Garantía Prendaria","4"],
    #       ["Garantia Hipotecaria","5"],
    #       ["Dos (2) codeudores laborando / un (1) codeudor con finca raiz + un (1) codeudor laborando",6],
    #       ["Garantía prendaria + un (1) codeudor laborando",7],
    #       ["Garantía hipotecaria + un (1) codeudor laborando",8],
    #       ["Dos (2) codeudores laborando / un (1) codeudor con finca raiz + dos (2) codeudores laborando / un (1) codeudor con finca raiz",9],
    #       ["Dos (2) codeudores laborando / un (1) codeudor con finca raiz+garantía prendaria",10],
    #       ["Dos (2) codeudores laborando / un (1) codeudor con finca raiz+garantía hipotecaria",11],
    #       ["Garantía prendaria + garantía prendaria",12],
    #       ["Garantía prendaria + garantía hipotecaria",13],
    #       ["Garantía hipotecaria + garantía hipotecaria",14]
    #     ]
  end

  def select_userintervalo
    [
      ['10 Minutos', 10],
      ['15 Minutos', 15],
      ['20 Minutos', 20],
      ['30 Minutos', 30],
      ['45 Minutos', 45],
      ['60 Minutos', 60]
    ]
  end

  def select_formapagohelena
    [
      %w[EFECTIVO EFECTIVO],
      %w[CONSIGNACION CONSIGNACION]
    ]
  end

  def select_tipoinmueble
    [
      %w[APARTAMENTO APARTAMENTO],
      ['APARTAMENTO USADO', 'APARTAMENTO USADO'],
      %w[AZOTEA AZOTEA],
      %w[BODEGA BODEGA],
      %w[CASA CASA],
      ['CASA USADA', 'CASA USADA'],
      %w[CONSULTORIO CONSULTORIO],
      %w[DEPARTAMENTO DEPARTAMENTO],
      ['DEPARTAMENTO - DUPLEX', 'DEPARTAMENTO - DUPLEX'],
      ['DEPARTAMENTO - FLAT', 'DEPARTAMENTO - FLAT'],
      %w[DEPOSITO DEPOSITO],
      %w[EDIFICIO EDIFICIO],
      %w[ESTACIONAMIENTO ESTACIONAMIENTO],
      %w[FINCA FINCA],
      %w[HOTEL HOTEL],
      %w[LOCAL LOCAL],
      %w[LOTE LOTE],
      %w[OFICINA OFICINA],
      %w[PARQUEADERO PARQUEADERO],
      %w[OTRO OTRO],
      %w[RESIDENCIAL RESIDENCIAL],
      ['PREDIO RURAL', 'PREDIO RURAL']
    ]
  end

  def select_tipohipoteca
    [
      %w[ABIERTA ABIERTA],
      ['ABIERTA DE CUANTIA INDETERMINADA', 'ABIERTA DE CUANTIA INDETERMINADA'],
      %w[CERRADA CERRADA],
      %w[GENERAL GENERAL],
      %w[ESPECIFICA ESPECIFICA]
    ]
  end

  def select_tipoafectacion
    [
      ['AFECTACION A VIVIENDA FAMILIAR', 'AFECTACION A VIVIENDA FAMILIAR'],
      ['CONDICION RESOLUTORIA', 'CONDICION RESOLUTORIA'],
      ['PATRIMONIO DE FAMILIA INEMBARGABLE', 'PATRIMONIO DE FAMILIA INEMBARGABLE'],
      %w[USUFRUCTO USUFRUCTO]
    ]
  end

  def select_origen
    [
      %w[MULTA MULTA],
      %w[SANCION SANCION],
      %w[TRIBUTO TRIBUTO],
      %w[SENTENCIA SENTENCIA],
      %w[RENTA RENTA],
      %w[CAUCION CAUCION]
    ]
  end

  def select_nomenclatura
    [
      %w[AUTOPISTA AUTOPISTA],
      %w[AVENIDA AVENIDA],
      ['AVENIDA CALLE', 'AVENIDA CALLE'],
      ['AVENIDA CARRERA', 'AVENIDA CARRERA'],
      %w[BULEVAR BULEVAR],
      %w[CALLE CALLE],
      %w[CARRERA CARRERA],
      %w[CIRCULAR CIRCULAR],
      %w[KILOMETRO KILOMETRO],
      %w[CIRCUNVALAR CIRCUNVALAR],
      ['CTAS CORRIDAS', 'CTAS CORRIDAS'],
      %w[DIAGONAL DIAGONAL],
      %w[PASAJE PASAJE],
      %w[PASEO PASEO],
      %w[PEATONAL PEATONAL],
      %w[TRANSVERSAL TRANSVERSAL],
      %w[TRONCAL TRONCAL],
      %w[VARIANTE VARIANTE],
      %w[VIA VIA]
    ]
  end

  def select_nomenclatura_exp
    [
      ['AVENIDA CALLE', 'AC'],
      %w[ADMINISTRACIÓN AD],
      %w[ADELANTE ADL],
      %w[AEROPUERTO AER],
      %w[AGENCIA AG],
      %w[AGRUPACIÓN AGP],
      ['AVENIDA CARRERA', 'AK'],
      %w[ALTILLO AL],
      ['AL LADO', 'ALD'],
      %w[ALMACÉN ALM],
      %w[APARTAMENTO AP],
      %w[APARTADO APTDO],
      %w[ATRÁS ATR],
      %w[AUTOPISTA AUT],
      %w[AVENIDA AV],
      ['ANILLO VIAL', 'AVIAL'],
      %w[BODEGA BG],
      %w[BLOQUE BL],
      %w[BOULEVARD BLV],
      %w[BARRIO BRR],
      %w[CORREGIMIENTO C],
      %w[CASA CA],
      %w[CASERÍO CAS],
      ['CENTRO COMERCIAL', 'CC'],
      %w[CIUDADELA CD],
      %w[CÉLULA CEL],
      %w[CENTRO CEN],
      %w[CIRCULAR CIR],
      %w[CALLE CL],
      %w[CALLEJÓN CLJ],
      %w[CAMINO CN],
      ['CONJUNTO RESIDENCIAL', 'CON'],
      %w[CONJUNTO CONJ],
      %w[CARRERA CR],
      %w[CARRETERA CRT],
      %w[CIRCUNVALAR CRV],
      %w[CONSULTORIO CS],
      %w[DIAGONAL DG],
      %w[DEPÓSITO DP],
      %w[DEPARTAMENTO DPTO],
      ['DEPÓSITO SÓTANO', 'DS'],
      %w[EDIFICIO ED],
      %w[ENTRADA EN],
      %w[ESCALERA ES],
      %w[ESQUINA ESQ],
      %w[ESTE ESTE],
      %w[ETAPA ET],
      %w[EXTERIOR EX],
      %w[FINCA FCA],
      %w[GARAJE GJ],
      ['GARAJE SÓTANO', 'GS'],
      %w[GLORIETA GT],
      %w[HACIENDA HC],
      %w[HANGAR HG],
      %w[INTERIOR IN],
      ['INSPECCIÓN DE POLICÍA', 'IP'],
      ['INSPECCIÓN DEPARTAMENTAL', 'IPD'],
      ['INSPECCIÓN MUNICIPAL', 'IPM'],
      %w[KILÓMETRO KM],
      %w[LOCAL LC],
      ['LOCAL MEZZANINE', 'LM'],
      %w[LOTE LT],
      %w[MÓDULO MD],
      %w[MOJÓN MJ],
      %w[MUELLE MLL],
      %w[MEZZANINE MN],
      %w[MANZANA MZ],
      ['VÍAS DE NOMBRE COMÚN', 'NOMBRE VIA'],
      %w[NORTE NORTE],
      %w[ORIENTE O],
      %w[OCCIDENTE OCC],
      %w[OESTE OESTE],
      %w[OFICINA OF],
      %w[PISO P],
      %w[PARCELA PA],
      %w[PARQUE PAR],
      %w[PREDIO PD],
      %w[PENTHOUSE PH],
      %w[PASAJE PJ],
      %w[PLANTA PL],
      %w[PUENTE PN],
      %w[PORTERÍA POR],
      %w[POSTE POS],
      %w[PARQUEADERO PQ],
      %w[PARAJE PRJ],
      %w[PASEO PS],
      %w[PUESTO PT],
      ['PARK WAY', 'PW'],
      ['ROUND POINT', 'RP'],
      %w[SALÓN SA],
      ['SALÓN COMUNAL', 'SC'],
      %w[SALIDA SD],
      %w[SECTOR SEC],
      %w[SOLAR SL],
      ['SÚPER MANZANA', 'SM'],
      %w[SEMISÓTANO SS],
      %w[SÓTANO ST],
      %w[SUITE SUITE],
      %w[SUR SUR],
      %w[TERMINAL TER],
      %w[TERRAPLÉN TERPLN],
      %w[TORRE TO],
      %w[TRANSVERSAL TV],
      %w[TERRAZA TZ],
      %w[UNIDAD UN],
      ['UNIDAD RESIDENCIAL', 'UR'],
      %w[URBANIZACIÓN URB],
      %w[VEREDA VRD],
      %w[VARIANTE VTE],
      ['ZONA FRANCA', 'ZF'],
      %w[ZONA ZN]
    ]
  end

  def select_nomenclaturaletra
    [
      %w[SUR SUR],
      %w[NORTE NORTE],
      %w[ESTE ESTE],
      %w[OESTE OESTE],
      %w[BIS BIS]
    ]
  end

  def select_porcentaje
    [
      ['5%', 5],
      ['10%', 10],
      ['15%', 15],
      ['16%', 16],
      ['17%', 17],
      ['18%', 18],
      ['19%', 19],
      ['20%', 20],
      ['21%', 21],
      ['22%', 22],
      ['23%', 23],
      ['24%', 24],
      ['25%', 25],
      ['26%', 26],
      ['27%', 27],
      ['28%', 28],
      ['29%', 29],
      ['30%', 30],
      ['31%', 31],
      ['32%', 32],
      ['33%', 33],
      ['34%', 34],
      ['35%', 35],
      ['36%', 36],
      ['37%', 37],
      ['38%', 38],
      ['39%', 39],
      ['40%', 40],
      ['41%', 41],
      ['42%', 42],
      ['43%', 43],
      ['44%', 44],
      ['45%', 45],
      ['46%', 46],
      ['47%', 47],
      ['48%', 48],
      ['49%', 49],
      ['50%', 50],
      ['51%', 51],
      ['52%', 52],
      ['53%', 53],
      ['54%', 54],
      ['55%', 55],
      ['56%', 56],
      ['57%', 57],
      ['58%', 58],
      ['59%', 59],
      ['60%', 60]
    ]
  end

  def select_plazoinicial
    [
      ['1', 1],
      ['2', 2],
      ['3', 3],
      ['4', 4],
      ['5', 5],
      ['6', 6],
      ['7', 7],
      ['8', 8],
      ['9', 9],
      ['10', 10],
      ['11', 11],
      ['12', 12],
      ['13', 13],
      ['14', 14],
      ['15', 15],
      ['16', 16],
      ['17', 17],
      ['18', 18],
      ['19', 19],
      ['20', 20],
      ['21', 21],
      ['22', 22],
      ['23', 23],
      ['24', 24]
    ]
  end

  def select_ciclos
    [
      ['05', '05'],
      ['10', '10'],
      ['15', '15'],
      ['20', '20'],
      ['25', '25'],
      ['30', '30']
    ]
  end

  def select_tiposarchivos
    if is_portafolio == 10140
      [
        ['INMUEBLES', 'INMUEBLES']
      ]
    elsif is_portafolio == 10020
      [
        ['PROCESOS', 'PROCESOS']
      ]
    else
      [
        ['SIN INFO', 'SIN INFO']
      ]
    end
  end

  def select_tipocuentabanco
    [
      ['CORRIENTE', 'CC'],
      ['AHORROS', 'CA']
    ]
  end

  def select_clasecuentapago
    [
      ['UNIVERSIDAD', 'UNIVERSIDAD'],
      ['PORTAFOLIO', 'PORTAFOLIO'],
      ['CARTERA', 'CARTERA']
    ]
  end

  def select_calificaciontelefono
    [
      %w[APAGADO APAGADO],
      ['DIRECCION ERRADA', 'DIRECCION ERRADA'],
      ['DIRECCION NO EXISTE', 'DIRECCION NO EXISTE'],
      ['DIRECCION TITULAR', 'DIRECCION TITULAR'],
      %w[ERRADO ERRADO],
      %w[FALLECIDO FALLECIDO],
      ['NO ABREN PUERTA', 'NO ABREN PUERTA'],
      ['NO CONTESTAN', 'NO CONTESTAN'],
      ['NO EXISTE', 'NO EXISTE'],
      %w[TERCERO TERCERO],
      %w[TITULAR TITULAR],
      ['ZONA PELIGROSA', 'ZONA PELIGROSA']
    ]
  end

  def select_estadosdeudor
    is_select_estadosdeudor
  end

  def select_tiposgestion
    [
      %w[COBRANZA COBRANZA],
      %w[VIRTUAL VIRTUAL]
    ]
  end

  def active_class(link_path)
    current_page?(link_path) ? 'active' : ''
  end

  def camponumerico_nologin(valor)
    number_to_currency(valor, precision: 0, unit: '', delimiter: '.')
  end

  def camponumerico(valor)
    number_to_currency(valor, precision: 0, unit: '', delimiter: '.')
  end

  def camponumerico2(valor)
    if is_portafolio == 10014
      number_to_currency(valor, precision: 0, unit: '', delimiter: ',', separator: '.')
    else
      number_to_currency(valor, precision: 0, unit: '', delimiter: '.')
    end
  end

  def camponumerico3(valor)
    if is_portafolio == 10014
      number_to_currency(valor, precision: 3, unit: '', delimiter: ',', separator: '.')
    else
      number_to_currency(valor, precision: 3, unit: '', delimiter: '.')
    end
  end

  def camponumerico4(valor)
    if is_portafolio == 10014
      number_to_currency(valor, precision: 1, unit: '', delimiter: ',', separator: '.')
    else
      number_to_currency(valor, precision: 1, unit: '', delimiter: '.')
    end
  end

  def camponumerico5(valor)
    number_to_currency(valor, precision: 0, unit: '', delimiter: '', separator: '')
  end

  def camponumerico6(valor)
    number_to_currency(valor, precision: 8, unit: '', delimiter: '', separator: '')
  end

  def camponumerico7(valor)
    if is_portafolio == 10014
      number_to_currency(valor, precision: 4, unit: '', delimiter: ',', separator: '.')
    else
      number_to_currency(valor, precision: 4, unit: '', delimiter: '.')
    end
  end

  def camponumerico8(valor)
    number_to_currency(valor, precision: 0, unit: '', delimiter: '.')
  end

  def select_zona
    [
      %w[LIMA LIMA],
      %w[PROVINCIA PROVINCIA]
    ]
  end

  def select_aplicable_a
    [
      ['PAGO_MINIMO', 'PAGO_MINIMO'],
      ['SALDO_TOTAL', 'SALDO_TOTAL']
    ]
  end

  def select_vehiculo(portafolioid)
    is_select_vehiculo(portafolioid)
  end

  def select_capacidadex
    [
      ['NO APLICA', 'NO APLICA'],
      ['TALENTO EXCEPCIONAL GENERAL', 'TALENTO EXCEPCIONAL GENERAL'],
      ['TALENTO EXCEPCIONAL ESPECÍFICO', 'TALENTO EXCEPCIONAL ESPECÍFICO']
    ]
  end

  def select_zonaedu
    [
      %w[URBANA URBANA],
      %w[RURAL RURAL]
    ]
  end

  def select_medio
    [
      ['ALGUIEN LE CONTÓ', 'ALGUIEN LE CONTÓ'],
      ['LE ENTREGARON UN VOLANTE', 'LE ENTREGARON UN VOLANTE'],
      ['LO LLAMARON', 'LO LLAMARON'],
      ['MEDIOS DE COMUNICACIÓN (RADIO, TV O PRENSA)', 'MEDIOS DE COMUNICACIÓN (RADIO, TV O PRENSA)'],
      ['PASABA POR EL LOCAL', 'PASABA POR EL LOCAL'],
      ['PLAN AMIGOS', 'PLAN AMIGOS'],
      ['REDES SOCIALES O PAGINA WEB', 'REDES SOCIALES O PAGINA WEB'],
      ['TRABAJA EN EDUPOL', 'TRABAJA EN EDUPOL']
    ]
  end

  def select_medioexperiencia
    [
      ['ALGUIEN LE CONTÓ', 'ALGUIEN LE CONTÓ'],
      ['LE ENTREGARON UN VOLANTE', 'LE ENTREGARON UN VOLANTE'],
      ['LO LLAMARON', 'LO LLAMARON'],
      ['MEDIOS DE COMUNICACIÓN (RADIO, TV O PRENSA)', 'MEDIOS DE COMUNICACIÓN (RADIO, TV O PRENSA)'],
      ['PASABA POR EL LOCAL', 'PASABA POR EL LOCAL'],
      ['PLAN AMIGOS', 'PLAN AMIGOS'],
      ['REDES SOCIALES O PAGINA WEB', 'REDES SOCIALES O PAGINA WEB'],
      ['TRABAJA EN EXPERIENCIA', 'TRABAJA EN EXPERIENCIA'],
      ['TALLER', 'TALLER'],
      ['REFERIDO', 'REFERIDO']
    ]
  end

  def select_origendineropago
    [
      ['RECURSOS PROPIOS', 'RECURSOS PROPIOS'],
      ['FINANCIACIÓN TERCERO', 'FINANCIACIÓN TERCERO'],
      %w[EDUPOL EDUPOL]
    ]
  end

  def select_actividadeconomica
    [
      %w[DEPENDIENTE DEPENDIENTE],
      %w[EMPLEADO EMPLEADO],
      %w[INDEPENDIENTE INDEPENDIENTE],
      %w[DESEMPLEADO DESEMPLEADO],
      %w[INFORMAL INFORMAL]
    ]
  end

  def select_tipovivienda
    [
      %w[PROPIA PROPIA],
      %w[FAMILIAR FAMILIAR],
      %w[ARRIENDO ARRIENDO]
    ]
  end

  def tipo_solicitud
    [
      ['NUEVO (POR PRIMERA VEZ)', 'NUEVO (POR PRIMERA VEZ)'],
      %w[REINGRESO REINGRESO],
      %w[RENOVACION RENOVACION]
    ]
  end

  def tipo_solicitud2
    [
      %w[NUEVOS NUEVO],
      %w[REINGRESOS REINGRESO],
      %w[RENOVACIONES RENOVACION]
    ]
  end

  def select_tipodocproceso
    [
      %w[LEGALIZACIÓN LEGALIZACION],
      %w[RENOVACIÓN RENOVACION]
    ]
  end

  def select_bandeja
    [
      %w[INCOMPLETA PENDIENTE],
      %w[RADICADA ENVIADA],
      %w[APROBADA APROBADA],
      %w[RECHAZADA RECHAZADA],
      %w[DEVUELTA DEVOLUCIONES]
    ]
  end

  def select_estadocredito
    [
      ['AL DIA', 'AL DIA'],
      ['EN MORA', 'EN MORA'],
      %w[VENCIDO VENCIDO],
      %w[CASTIGADA CASTIGADA],
      %w[CANCELADO CANCELADO]
    ]
  end

  def select_tipoprograma
    [
      %w[FORMAL FORMAL],
      ['NO FORMAL', 'NO FORMAL']
    ]
  end

  def select_formapago
    [
      %w[CONTADO CONTADO],
      %w[FINANCIACION FINANCIACION],
      %w[AMBOS AMBOS]
    ]
  end

  def select_estrato
    [
      ['ESTRATO 0', 'ESTRATO 0'],
      ['ESTRATO 1', 'ESTRATO 1'],
      ['ESTRATO 2', 'ESTRATO 2'],
      ['ESTRATO 3', 'ESTRATO 3'],
      ['ESTRATO 4', 'ESTRATO 4'],
      ['ESTRATO 5', 'ESTRATO 5'],
      ['ESTRATO 6', 'ESTRATO 6']
    ]
  end

  def select_gruposang
    [
      ['O+', 'O+'],
      ['O-', 'O-'],
      ['A+', 'A+'],
      ['A-', 'A-'],
      ['B+', 'B+'],
      ['B-', 'B-'],
      ['AB+', 'AB+'],
      ['AB-', 'AB-']
    ]
  end

  def tiposgatos
    [
      %w[FACTURA FACTURA],
      %w[BOLETA BOLETA],
      ['RECIBO POR HONORARIOS', 'RECIBO POR HONORARIOS'],
      %w[COMPROBANTE COMPROBANTE],
      ['FACTURA SIN DETRACCION', 'FACTURA SIN DETRACCION']
    ]
  end

  def select_denomincacion
    [
      %w[COP COP],
      %w[UVR UVR],
      %w[USD USD],
      %w[SOLES PEN],
      %w[EUROS EUR]
    ]
  end

  def select_bpo_gps
    [
      ['Broker (BPO)', 'BPO'],
      ['Reo GPS', 'GPS']
    ]
  end

  def selectformapagoedu
    [
      ['AJUSTE POR TRASLADO CUOTA INICIAL', 'AJUSTE POR TRASLADO CUOTA INICIAL'],
      %w[AJUSTE AJUSTE],
      ['AJUSTE POR R. E.', 'AJUSTE POR R. E.'],
      %w[BECA BECA],
      %w[CESANTIAS CESANTIAS],
      %w[CHEQUES CHEQUES],
      ['CRUCE CON UNIVERSIDADES', 'CRUCE CON UNIVERSIDADES'],
      ['DESCUENTO POR NOMINA', 'DESCUENTO POR NOMINA'],
      %w[ICETEX ICETEX],
      ['PAGO EN BANCO', 'PAGO EN BANCO'],
      ['PAGO EN BANCO BANCOLOMBIA', 'PAGO EN BANCO BANCOLOMBIA'],
      ['PAGO EN BANCO DAVIVIENDA', 'PAGO EN BANCO DAVIVIENDA'],
      ['PAGO EN BANCO BANCO DE BOGOTA', 'PAGO EN BANCO BANCO DE BOGOTA '],
      ['PAGO EN BANCO COLPATRIA', 'PAGO EN BANCO COLPATRIA'],
      ['PAGO EN BANCO BANCO AGRARIO', 'PAGO EN BANCO BANCO AGRARIO'],
      ['PAGO EN EFECTIVO', 'PAGO EN EFECTIVO'],
      ['PAGO POR TARJETA DE CREDITO', 'PAGO POR TARJETA DE CREDITO'],
      ['PAGO PSE TRANSFERENCIA BANCARIA', 'PAGO PSE TRANSFERENCIA BANCARIA'],
      ['PAYU BOTONES', 'PAYU BOTONES'],
      ['PAYU RECAUDOS', 'PAYU RECAUDOS'],
      ['PAYU WEB CHECKOUT', 'PAYU WEB CHECKOUT'],
      ['PLAN AMIGOS', 'PLAN AMIGOS'],
      %w[RE-CLASIFICACIÓN RE-CLASIFICACION],
      ['TRASLADO SFC', 'TRASLADO SFC'],
      ['TRASLADO CUOTA INICIAL', 'TRASLADO CUOTA INICIAL'],
      ['TRASLADO VALOR ABONO A CUOTAS 2018-1', 'TRASLADO VALOR ABONO A CUOTAS 2018-1'],
      ['TRASLADO VALOR CUOTA INICIAL 2018-1', 'TRASLADO VALOR CUOTA INICIAL 2018-1'],
      ['TRASLADO VALOR CUOTA INICIAL DE 2018-2', 'TRASLADO VALOR CUOTA INICIAL DE 2018-2'],
      ['TRASLADO VALOR ABONO CUOTAS DE 2018-2', 'TRASLADO VALOR ABONO CUOTAS DE 2018-2'],
      ['SALDO DE SEMESTRES ANTERIORES', 'SALDO DE SEMESTRES ANTERIORES'],
      ['UTILIDADES DEL CAU', 'UTILIDADES DEL CAU'],
      ['DESCUENTO POR ALIANZA', 'DESCUENTO POR ALIANZA'],
      ['DESCUENTO COMERCIAL PROFESIONALIZANTE', 'DESCUENTO COMERCIAL PROFESIONALIZANTE']
    ]
  end

  def selectformapagoexp
    [
      ['AJUSTE POR TRASLADO PIN EXPERIENCIA', 'AJUSTE POR TRASLADO PIN EXPERIENCIA'],
      %w[AJUSTE AJUSTE],
      %w[BECA BECA],
      %w[CESANTIAS CESANTIAS],
      %w[CHEQUES CHEQUES],
      ['CRUCE CON UNIVERSIDADES', 'CRUCE CON UNIVERSIDADES'],
      ['DESCUENTO POR NOMINA', 'DESCUENTO POR NOMINA'],
      %w[ICETEX ICETEX],
      ['PAGO EN BANCO', 'PAGO EN BANCO'],
      ['PAGO EN BANCO BANCOLOMBIA', 'PAGO EN BANCO BANCOLOMBIA'],
      ['PAGO EN BANCO DAVIVIENDA', 'PAGO EN BANCO DAVIVIENDA'],
      ['PAGO EN BANCO BANCO DE BOGOTA', 'PAGO EN BANCO BANCO DE BOGOTA '],
      ['PAGO EN BANCO COLPATRIA', 'PAGO EN BANCO COLPATRIA'],
      ['PAGO EN BANCO BANCO AGRARIO', 'PAGO EN BANCO BANCO AGRARIO'],
      ['PAGO EN EFECTIVO', 'PAGO EN EFECTIVO'],
      ['PAGO POR TARJETA DE CREDITO', 'PAGO POR TARJETA DE CREDITO'],
      ['PAGO PSE TRANSFERENCIA BANCARIA', 'PAGO PSE TRANSFERENCIA BANCARIA'],
      ['PAYU BOTONES', 'PAYU BOTONES'],
      ['PAYU RECAUDOS', 'PAYU RECAUDOS'],
      ['PAYU WEB CHECKOUT', 'PAYU WEB CHECKOUT'],
      %w[RE-CLASIFICACIÓN RE-CLASIFICACION],
      ['SALDO DE SEMESTRES ANTERIORES', 'SALDO DE SEMESTRES ANTERIORES'],
      ['UTILIDADES DEL PUNTO DE EXPERIENCIA', 'UTILIDADES DEL PUNTO DE EXPERIENCIA'],
      ['DESCUENTO POR ALIANZA', 'DESCUENTO POR ALIANZA'],
      ['DESCUENTO COMERCIAL PROFESIONALIZANTE', 'DESCUENTO COMERCIAL PROFESIONALIZANTE']
    ]
  end

  def select_estadogastos
    [
      %w[SOLICITADO SOLICITADO],
      ['NO APROBADO', 'NO APROBADO'],
      ['RECHAZADO REEMBOLSO/GIRO', 'RECHAZADO REEMBOLSO/GIRO'],
      ['ENVIO REEMBOLSO/GIRO', 'ENVIO REEMBOLSO/GIRO'],
      ['PENDIENTE ENVIO REEMBOLSO/GIRO', 'PENDIENTE ENVIO REEMBOLSO/GIRO'],
      ['REEMBOLSO/GIRO', 'REEMBOLSO/GIRO'],
      ['REPORTE FORMATO REEMBOLSO', 'REPORTE FORMATO REEMBOLSO']
    ]
  end

  def select_estadogastosreo
    [
      %w[SOLICITADO SOLICITADO],
      %w[APROBADO APROBADO],
      ['NO APROBADO', 'NO APROBADO'],
      ['CON OBSERVACION', 'CON OBSERVACION'],
      %w[ENVIADO ENVIADO],
      ['PENDIENTE ENVIO REEMBOLSO/GIRO', 'PENDIENTE ENVIO REEMBOLSO/GIRO'],
      %w[PROCESADO PROCESADO],
      %w[RECHAZADO RECHAZADO]
    ]
  end

  def select_caracteristicatitulo_gps
    [
      ['EJECUCION DE GARANTIA HIPOTECARIA', 'EJECUCION DE GARANTIA HIPOTECARIA'],
      ['MEDIDA CAUTELAR', 'MEDIDA CAUTELAR'],
      ['EJECUCION DE GARANTIA INMOBILIARIA- EGI', 'EJECUCION DE GARANTIA INMOBILIARIA- EGI'],
      ['OBLIGACION DE DAR SUMA DE DINERO - ODSD', 'OBLIGACION DE DAR SUMA DE DINERO - ODSD'],
      ['PRUEBA ANTICIPADA', 'PRUEBA ANTICIPADA'],
      ['INCAUTACION', 'INCAUTACION'],
      ['SIN VERIFICAR', 'SIN VERIFICAR']
    ]
  end

  def select_tipojuzgado_gps
    [
      %w[JM JM],
      %w[JPL JPL],
      %w[JC JC],
      %w[JCC JCC]
    ]
  end

  def select_forma_vmn
    [
      ['POR ORIGINADOR SALDO CAPITAL', 'ORIGINADORSALDOCAPITAL'],
      ['POR ORIGINADOR SALDO TOTAL', 'ORIGINADORSALDOTOTAL'],
      ['POR VEHICULO SALDO CAPITAL', 'VEHICULOSALDOCAPITAL'],
      ['POR VEHICULO SALDO TOTAL', 'VEHICULOSALDOTOTAL'],
      ['POR POLITICA OBLIGACION', 'POLITICAOBLIGACION']
    ]
  end

  def select_situacion_titular
    [
      ['NORMAL', 0],
      ['CONCORDATO', 1],
      ['LIQUIDACIÓN FORZOSA', 2],
      ['LIQUIDACIÓN VOLUNTARIA', 3],
      ['PROCESO DE REORGANIZACIÓN', 4],
      ['LEY 550', 5],
      ['LEY 1116', 6],
      ['OTRA', 7]
    ]
  end

  def select_c2tipoempresa
    [
      %w[PUBLICA PUBLICA],
      %w[PRIVADA PRIVADA],
      %w[MIXTA MIXTA]
    ]
  end

  def select_estadotanque
    is_select_estadotanque
  end

  def select_controltanque
    is_select_controltanque
  end

  def select_cuentatanque
    is_select_cuentatanque
  end

  def select_origendato
    [
      %w[VUR VUR],
      %w[ORIP ORIP]
    ]
  end

  def select_origendatov
    [
      %w[RUNT RUNT],
      %w[OTRO OTRO]
    ]
  end

  def select_origendatoe
    [
      %w[RUES RUES],
      %w[OTRO OTRO]
    ]
  end

  def select_periodicidad
    [
      %w[MENSUAL MENSUAL],
      %w[BIMESTRAL BIMESTRAL],
      %w[TRIMESTRAL TRIMESTRAL],
      %w[SEMESTRAL SEMESTRAL],
      %w[ANUAL ANUAL],
      %w[NINGUNA NINGUNA]
    ]
  end

  def select_periodicidad_2
    [
      ['MENSUAL', 1],
      ['BIMESTRAL', 2],
      ['TRIMESTRAL', 3],
      ['SEMESTRAL', 6],
      ['ANUAL', 12],
      ['NINGUNA', 0]
    ]
  end

  def select_vigilancia
    [
      %w[LLAVES LLAVES],
      %w[ALARMA ALARMA],
      %w[AGENTE AGENTE],
      ['TERRENOS AGRICOLAS', 'TERRENOS AGRICOLAS'],
      %w[TERRENOS TERRENOS],
      %w[OTROS OTROS]
    ]
  end

  def select_tipo_gestion
    [
      ['LLAMADA TELEFONICA', 'LLAMADA TELEFONICA'],
      %w[EMAIL EMAIL],
      %w[VISITA VISITA],
      %w[OTROS OTROS]
    ]
  end

  def select_perumunicipio
    is_select_perumunicipio
  end

  def select_tiposervicio
    [
      %w[PUBLICO PUBLICO],
      %w[PRIVADO PRIVADO],
      %w[OFICIAL OFICIAL]
    ]
  end

  def tipo_deudor
    [
      %w[CODEUDOR CODEUDOR],
      ['PROPITARIO INSCRITO', 'PROPITARIO INSCRITO'],
      %w[ESTUDIANTE ESTUDIANTE],
      ['ACREEDOR HIPOTECARIO', 'ACREEDOR HIPOTECARIO'],
      ['ACREEDOR PRENTARIO', 'ACREEDOR PRENTARIO'],
      ['GARANTE HIPOTECARIO', 'GARANTE HIPOTECARIO'],
      ['FIADOR SOLIDARIO', 'FIADOR SOLIDARIO'],
      ['AVAL 2', 'AVAL 2']
    ]
  end

  def select_tipobien
    [
      %w[VEHICULO VEHICULO],
      %w[INMUEBLE INMUEBLE],
      ['ACTIVOS FINANCIEROS', 'ACTIVOS FINANCIEROS']
    ]
  end

  def select_disponibilidad
    [

      %w[AVAILABLE AVAILABLE],
      %w[NON-AVAILABLE NON-AVAILABLE],
      ['AVAILABLE - KEYS', 'AVAILABLE - KEYS'],
      ['AVAILABLE - LETTER', 'AVAILABLE - LETTER'],
      ['NOT AVAILABLE', 'NOT AVAILABLE']
    ]
  end

  def select_zonagps
    [
      %w[NON-LIMA NON-LIMA],
      %w[LIMA LIMA]
    ]
  end

  def select_gps_loan
    [
      %w[Registered Registered],
      ['Not Registered', 'Not Registered'],
      ['In process', 'In process']
    ]
  end

  def select_gps_pst
    [
      %w[Registered Registered],
      ['Not Registered', 'Not Registered']
    ]
  end

  def select_gps_status
    [
      %w[UNLISTED UNLISTED],
      %w[LISTED LISTED],
      ['SALE CONCLUDED', 'SALE CONCLUDED'],
      ['OFFER ACCEPTED', 'OFFER ACCEPTED'],
      %w[PUTBACK PUTBACK],
      %w[KICKOUT KICKOUT]
    ]
  end

  def select_gps_statusform
    [
      %w[UNLISTED UNLISTED],
      %w[PUTBACK PUTBACK],
      %w[KICKOUT KICKOUT]
    ]
  end

  def select_gps_statusform2
    [
      ['UNLISTED'],
      ['PUTBACK'],
      ['KICKOUT']
    ]
  end

  def select_gps_disponible
    [
      %w[Available Available],
      %w[Non-available Non-available],
      ['Available - keys', 'Available - keys'],
      ['Available - letter', 'Available - letter']
    ]
  end

  def select_tipoinmueblebuscador(portafolioid)
    is_select_tipoinmueblebuscador(portafolioid)
  end

  def select_procesostiponotificacion
    [
      ['NOTIFICACION 291', 'NOTIFICACION 291'],
      ['NOTIFICACION 292', 'NOTIFICACION 292'],
      ['NOTIFICACION 293', 'NOTIFICACION 293'],
      ['NOTIFICACION 294', 'NOTIFICACION 294'],
      ['NOTIFICACION 295', 'NOTIFICACION 295'],
      ['NOTIFICACION 301', 'NOTIFICACION 301'],
      ['NOTIFICACION 315', 'NOTIFICACION 315'],
      ['NOTIFICACION 318', 'NOTIFICACION 318'],
      ['NOTIFICACION 320', 'NOTIFICACION 320'],
      ['NOTIFICACION 330', 'NOTIFICACION 330']
    ]
  end

  def select_procesostiporiesgo
    [
      %w[APELACION APELACION],
      ['DESISTIMIENTO TACITO', 'DESISTIMIENTO TACITO'],
      %w[EXCEPCIONES EXCEPCIONES],
      %w[NULIDAD NULIDAD],
      %w[PERENCION PERENCION]
    ]
  end

  def select_procesoscausales
    [
      ['CESION DE DERECHOS', 'CESION DE DERECHOS'],
      ['DESISTIMIENTO TACITO', 'DESISTIMIENTO TACITO'],
      %w[NOVACION NOVACION],
      ['PAGO CUOTAS EN MORA', 'PAGO CUOTAS EN MORA'],
      ['PAGO TOTAL', 'PAGO TOTAL'],
      ['PROCESO DE REORGANIZACION', 'PROCESO DE REORGANIZACION'],
      %w[REESTRUCTURACION REESTRUCTURACION],
      ['SENTENCIA DE RESTITUCION', 'SENTENCIA DE RESTITUCION'],
      ['SENTENCIA EN CONTRA', 'SENTENCIA EN CONTRA'],
      ['TERMINADO POR DESISTIIMIENTO DE LAS PRETENSIONES', 'TERMINADO POR DESISTIIMIENTO DE LAS PRETENSIONES'],
      ['TERMINADO POR DESISTIMIENTO DE LOS EFECTOS DE LA SENTENCIA', 'TERMINADO POR DESISTIMIENTO DE LOS EFECTOS DE LA SENTENCIA'],
      %w[OTRO OTRO]

    ]
  end

  def select_procesossuspencion
    [
      ['AUTO SUSPENDE PROCESO', 'AUTO SUSPENDE PROCESO'],
      ['SE SOLICITA SUSPENSION DEL PROCESO', 'SE SOLICITA SUSPENSION DEL PROCESO'],
      ['RECHAZA SUSPENSION', 'RECHAZA SUSPENSION'],
      ['JUZGADO REANUDA PROCESO', 'JUZGADO REANUDA PROCESO'],
      ['JUZGADO REQUIERE PARA SUSPENSION', 'JUZGADO REQUIERE PARA SUSPENSION'],
      ['RECHAZA SUSPENSION', 'RECHAZA SUSPENSION'],
      ['SE SOLICITA SUSPENSION DEL PROCESO', 'SE SOLICITA SUSPENSION DEL PROCESO'],
      ['AUTO SUSPENDE PROCESO', 'AUTO SUSPENDE PROCESO']
    ]
  end

  def select_bpcliente
    [
      ['BBVA', 'BBVA'],
      ['BCP', 'BCP']
    ]
  end

  def select_estadobp
    [
      ['PENDIENTE', 'PENDIENTE'],
      ['APROBADO', 'APROBADO'],
      ['NO VIGENTE', 'NO VIGENTE']
    ]
  end

  def select_tanqueforma
    [
      ['APLICA CON FECHA ACTUAL', 'APLICACONFECHAACTUAL'],
      ['APLICA CON FECHA MOVIMIENTO', 'APLICACONFECHAMOVIMIENTO']
    ]
  end

  def select_tanqueaplicarec
    [
      ['APLICAR A LA MAYOR DEUDA', 'APLICADEUDA'],
      ['APLICAR A LA MAS VENCIDA', 'APLICAVENCIDA']
    ]
  end

  def select_subetapa
    [
      ['DE MAYOR CUANTIA', 'DE MAYOR CUANTIA'],
      ['DE MENOR CUANTIA', 'DE MENOR CUANTIA'],
      ['DE MINIMA CUANTIA', 'DE MINIMA CUANTIA']
    ]
  end

  def select_subetapaconal
    [
      ['APREHENSION Y ENTREGA', 'APREHENSION Y ENTREGA'],
      ['CON TITULO PRENDARIO DE MENOR CUANTIA', 'CON TITULO PRENDARIO DE MENOR CUANTIA'],
      ['CON TITULO PRENDARIO DE MINIMA CUANTIA', 'CON TITULO PRENDARIO DE MINIMA CUANTIA'],
      %w[EMPRESARIAL EMPRESARIAL],
      ['HIPOTECARIO DE MAYOR CUANTIA', 'HIPOTECARIO DE MAYOR CUANTIA'],
      ['INSOLVENCIA DE PERSONA NATURAL NO COMERCIANTE', 'INSOLVENCIA DE PERSONA NATURAL NO COMERCIANTE'],
      ['MIXTO CON TITULO HIPOTECARIO', 'MIXTO CON TITULO HIPOTECARIO'],
      ['MIXTO CON TITULO PRENDARIO', 'MIXTO CON TITULO PRENDARIO'],
      %w[MIXTO MIXTO],
      ['PERSONA NATURAL NO COMERCIANTE', 'PERSONA NATURAL NO COMERCIANTE'],
      %w[PRENDARIO PRENDARIO],
      ['PRENDARIO/REORGANIZACION EMPRESARIAL', 'PRENDARIO/REORGANIZACION EMPRESARIAL'],
      ['REORGANIZACION EMPRESARIAL', 'REORGANIZACION EMPRESARIAL'],
      ['SINGULAR DE MAYOR CUANTIA', 'SINGULAR DE MAYOR CUANTIA'],
      ['SINGULAR DE MAYOR', 'SINGULAR DE MAYOR'],
      ['SINGULAR DE MENOR CUANTIA', 'SINGULAR DE MENOR CUANTIA'],
      ['SINGULAR DE MINIMA CUANTIA', 'SINGULAR DE MINIMA CUANTIA'],
      ['SINGULAR DE MINIMA', 'SINGULAR DE MINIMA'],
      %w[SINGULAR SINGULAR],
      ['VERBAL DE RESTITUCION DE TENENCIA', 'VERBAL DE RESTITUCION DE TENENCIA']
    ]
  end

  def select_grado
    [
      ['PRIMER GRADO', 'PRIMER GRADO'],
      ['SEGUNDO GRADO', 'SEGUNDO GRADO'],
      ['TERCER GRADO', 'TERCER GRADO']
    ]
  end

  def select_pagare
    [
      ['EN BLANCO', 'EN BLANCO'],
      %w[DILIGENCIADO DILIGENCIADO],
      ['SIN PAGARE', 'SIN PAGARE']
    ]
  end

  def select_base_externa
    [
      ['DATA CREDITO', 'DATA CREDITO'],
      %w[CIFIN CIFIN],
      %w[GESTION GESTION]
    ]
  end

  def select_corte
    [
      ['CORTE 5', 1],
      ['CORTE 20', 2]
    ]
  end

  def select_corte_2
    [
      ['CORTE 1', 1],
      ['CORTE 2', 2],
      ['CORTE 3', 3],
      ['CORTE 4', 4],
      ['CORTE 5', 5],
      ['CORTE 6', 6],
      ['CORTE 7', 7],
      ['CORTE 8', 8],
      ['CORTE 9', 9],
      ['CORTE 10', 10],
      ['CORTE 11', 11],
      ['CORTE 12', 12],
      ['CORTE 13', 13],
      ['CORTE 14', 14],
      ['CORTE 15', 15],
      ['CORTE 16', 16],
      ['CORTE 17', 17],
      ['CORTE 18', 18],
      ['CORTE 19', 19],
      ['CORTE 20', 20],
      ['CORTE 21', 21],
      ['CORTE 22', 22],
      ['CORTE 23', 23],
      ['CORTE 24', 24],
      ['CORTE 25', 25],
      ['CORTE 26', 26],
      ['CORTE 27', 27],
      ['CORTE 28', 28],
      ['CORTE 29', 29],
      ['CORTE 30', 30]
    ]
  end

  def select_brokers(portafolioid)
    is_select_broker(portafolioid)
  end

  def select_cuoperiodicidad
    [
      ['MENSUAL', 1],
      ['BIMESTRAL', 2],
      ['TRIMESTRAL', 3],
      ['SEMESTRAL', 6],
      ['ANUAL', 12]
    ]
  end

  def select_origensystem
    [
      %w[COMPRA COMPRA],
      %w[SUSTITUCION SUSTITUCION]
    ]
  end

  def select_procesojuridico
    [
      %w[ESTUDIOS ESTUDIOS],
      %w[ABOGADOS ABOGADOS],
      %w[DIRECTORES DIRECTORES],
      %w[ANALISTAS ANALISTAS]
    ]
  end

  def select_tipo_cartera
    [
      ['CARTERA ADMINISTRADA', 'CARTERA ADMINISTRADA'],
      ['CARTERA PROPIA', 'CARTERA PROPIA']
    ]
  end

  def select_parentesco
    [
      %w[NOSE NOSE]
    ]
  end

  def select_inmconfvisita
    [
      ['AAHH: Asentamiento Humano', 'AAHH: Asentamiento Humano'],
      ['PPJJ: Pueblo joven', 'PPJJ: Pueblo joven']
    ]
  end

  def select_inmtipoavaluo
    [
      %w[COMERCIAL COMERCIAL],
      %w[LIQUIDACION LIQUIDACION],
      %w[ESTIMADA ESTIMADA]
    ]
  end

  def select_inmestimadopor
    [
      %w[GPS GPS],
      %w[BROKER BROKER]
    ]
  end

  def select_inmresultadocn
    [
      %w[APROBADO APROBADO],
      ['NO APROBADO', 'NO APROBADO']
    ]
  end

  def select_ciudadprocesogca
    [
      ['ACACIAS - META', 'ACACIAS - META'],
      ['AGUADAS - CALDAS', 'AGUADAS - CALDAS'],
      ['ALBAN -CUNDINAMARCA', 'ALBAN -CUNDINAMARCA'],
      ['ANSERMA - CALDAS', 'ANSERMA - CALDAS'],
      ['APIA - RISARALDA', 'APIA - RISARALDA'],
      ['ARMENIA - QUINDIO', 'ARMENIA - QUINDIO'],
      ['BALBOA - RISARALDA', 'BALBOA - RISARALDA'],
      ['BARANOA - ATLANTICO', 'BARANOA - ATLANTICO'],
      ['BARBOSA - SANTANDER', 'BARBOSA - SANTANDER'],
      ['BARRANCABERMEJA - SANTANDER', 'BARRANCABERMEJA - SANTANDER'],
      ['BARRANQUILLA - ATLANTICO', 'BARRANQUILLA - ATLANTICO'],
      ['BELEN - CUNDINAMARCA', 'BELEN - CUNDINAMARCA'],
      ['BELEN DE UMBRIA - RISARALDA', 'BELEN DE UMBRIA - RISARALDA'],
      ['BELLO - ANTIOQUÍA', 'BELLO - ANTIOQUÍA'],
      ['BOGOTA - CUNDINAMARCA', 'BOGOTA - CUNDINAMARCA'],
      ['BUCARAMANGA - SANTANDER', 'BUCARAMANGA - SANTANDER'],
      ['BUENAVENTURA - VALLE', 'BUENAVENTURA - VALLE'],
      ['BUGA - VALLE', 'BUGA - VALLE'],
      ['CAICEDONIA - VALLE', 'CAICEDONIA - VALLE'],
      ['CAJIBIO - CAUCA', 'CAJIBIO - CAUCA'],
      ['CAJICA - CUNDINAMARCA', 'CAJICA - CUNDINAMARCA'],
      ['CALARCA - QUINDIO', 'CALARCA - QUINDIO'],
      ['CALDAS - ANTIOQUIA', 'CALDAS - ANTIOQUIA'],
      ['CALI - VALLE', 'CALI - VALLE'],
      ['CALIMA - VALLE', 'CALIMA - VALLE'],
      ['CANDELARIA - VALLE', 'CANDELARIA - VALLE'],
      ['CARTAGENA - BOLIVAR', 'CARTAGENA - BOLIVAR'],
      ['CARTAGO - VALLE', 'CARTAGO - VALLE'],
      ['CERETE - CORDOBA', 'CERETE - CORDOBA'],
      ['CHIA - CUNDINAMARCA', 'CHIA - CUNDINAMARCA'],
      ['CHIQUINQUIRA - BOYACA', 'CHIQUINQUIRA - BOYACA'],
      ['CIENAGA - MAGDALENA', 'CIENAGA - MAGDALENA'],
      ['CONTADERO - NARIÑO', 'CONTADERO - NARIÑO'],
      ['COPACABANA - ANTIOQUÍA', 'COPACABANA - ANTIOQUÍA'],
      ['COROZAL - SUCRE', 'COROZAL - SUCRE'],
      ['COTA - CUNDINAMARCA', 'COTA - CUNDINAMARCA'],
      ['CUCUNUBA - CUNDINAMARCA', 'CUCUNUBA - CUNDINAMARCA'],
      ['CUCUTA - N. DE SANTANDER', 'CUCUTA - N. DE SANTANDER'],
      ['DOSQUEBRADAS- RISARALDA', 'DOSQUEBRADAS- RISARALDA'],
      ['DUITAMA - BOYACA', 'DUITAMA - BOYACA'],
      ['EL BANCO - MAGDALENA', 'EL BANCO - MAGDALENA'],
      ['EL CERRITO - VALLE', 'EL CERRITO - VALLE'],
      ['EL COLEGIO - CUNDINAMARCA', 'EL COLEGIO - CUNDINAMARCA'],
      ['ENVIGADO - ANTIOQUIA', 'ENVIGADO - ANTIOQUIA'],
      ['ESPINAL - TOLIMA', 'ESPINAL - TOLIMA'],
      ['FACATATIVA - CUNDINAMARCA', 'FACATATIVA - CUNDINAMARCA'],
      ['FILANDIA - QUINDIO', 'FILANDIA - QUINDIO'],
      ['FLANDES - TOLIMA', 'FLANDES - TOLIMA'],
      ['FLORENCIA - CAQUETA', 'FLORENCIA - CAQUETA'],
      ['FLORIDABLANCA - SANTANDER', 'FLORIDABLANCA - SANTANDER'],
      ['FOMEQUE - CUNDINAMARCA', 'FOMEQUE - CUNDINAMARCA'],
      ['FUNZA -CUNDINAMARCA', 'FUNZA -CUNDINAMARCA'],
      ['FUSAGASUGA - CUNDINAMARCA', 'FUSAGASUGA - CUNDINAMARCA'],
      ['GACHANCIPA - CUNDINAMARCA', 'GACHANCIPA - CUNDINAMARCA'],
      ['GALAPA - ATLANTICO', 'GALAPA - ATLANTICO'],
      ['GIRARDOT - CUNDINAMARCA', 'GIRARDOT - CUNDINAMARCA'],
      ['GRANADA - CUNDINAMARCA', 'GRANADA - CUNDINAMARCA'],
      ['GIRARDOTA -ANTIOQUIA', 'GIRARDOTA -ANTIOQUIA'],
      ['GIRON - SANTANDER', 'GIRON - SANTANDER'],
      ['GUACARI - VALLE', 'GUACARI - VALLE'],
      ['GUACHUCAL - NARIÑO', 'GUACHUCAL - NARIÑO'],
      ['GUAMO - TOLIMA', 'GUAMO - TOLIMA'],
      ['GUASCA - CUNDINAMARCA', 'GUASCA - CUNDINAMARCA'],
      ['GUATICA - RISARALDA', 'GUATICA - RISARALDA'],
      ['IBAGUE - TOLIMA', 'IBAGUE - TOLIMA'],
      ['IPIALES - NARIÑO', 'IPIALES - NARIÑO'],
      ['ITAGUI - ANTIOQUÍA', 'ITAGUI - ANTIOQUÍA'],
      ['JAMUNDI - VALLE', 'JAMUNDI - VALLE'],
      ['KENNEDY - BOGOTA', 'KENNEDY - BOGOTA'],
      ['LA CALERA - CUNDINAMARCA', 'LA CALERA - CUNDINAMARCA'],
      ['LA CEJA - ANTIOQUÍA', 'LA CEJA - ANTIOQUÍA'],
      ['LA CUMBRE - VALLE', 'LA CUMBRE - VALLE'],
      ['LA ESTRELLA - ANTIOQUÍA', 'LA ESTRELLA - ANTIOQUÍA'],
      ['LA MESA -CUNDINAMARCA', 'LA MESA -CUNDINAMARCA'],
      ['LA UNION - VALLE', 'LA UNION - VALLE'],
      ['LA VIRGINIA - RISARALDA', 'LA VIRGINIA - RISARALDA'],
      ['LEBRIJA -SANTANDER', 'LEBRIJA -SANTANDER'],
      ['LETICIA - AMAZONAS', 'LETICIA - AMAZONAS'],
      ['LOS PATIOS - N. DE SANTANDER', 'LOS PATIOS - N. DE SANTANDER'],
      ['LURUACO - ATLANTICO', 'LURUACO - ATLANTICO'],
      ['MADRID - CUNDINAMARCA', 'MADRID - CUNDINAMARCA'],
      ['MALAGA - SANTANDER', 'MALAGA - SANTANDER'],
      ['MALAMBO - ATLANTICO', 'MALAMBO - ATLANTICO'],
      ['MAICAO - GUAJIRA', 'MAICAO - GUAJIRA'],
      ['MANATI - ATLANTICO', 'MANATI - ATLANTICO'],
      ['MANIZALES - CALDAS', 'MANIZALES - CALDAS'],
      ['MARINILLA - ANTIOQUÌA', 'MARINILLA - ANTIOQUÌA'],
      ['MARIQUITA- TOLIMA', 'MARIQUITA- TOLIMA'],
      ['MARSELLA - RISARALDA', 'MARSELLA - RISARALDA'],
      ['MEDELLIN - ANTIOQUÍA', 'MEDELLIN - ANTIOQUÍA'],
      ['MELGAR - TOLIMA', 'MELGAR - TOLIMA'],
      ['MISTRATO - RISARALDA', 'MISTRATO - RISARALDA'],
      ['MONTENEGRO - QUINDIO', 'MONTENEGRO - QUINDIO'],
      ['MONTERIA - CORDOBA', 'MONTERIA - CORDOBA'],
      ['MOSQUERA - CUNDINAMARCA', 'MOSQUERA - CUNDINAMARCA'],
      ['NEIRA - CALDAS', 'NEIRA - CALDAS'],
      ['NEIVA - HUILA', 'NEIVA - HUILA'],
      ['NEMOCON - CUNDINAMARCA', 'NEMOCON - CUNDINAMARCA'],
      ['OVEJAS - SUCRE', 'OVEJAS - SUCRE'],
      ['PAIPA - BOYACA', 'PAIPA - BOYACA'],
      ['PALMAR DE VARELA - ATLANTICO', 'PALMAR DE VARELA - ATLANTICO'],
      ['PALMIRA - VALLE', 'PALMIRA - VALLE'],
      ['PASTO -NARIÑO', 'PASTO -NARIÑO'],
      ['PEREIRA - RISARALDA', 'PEREIRA - RISARALDA'],
      ['PIEDECUESTA - SANTANDER', 'PIEDECUESTA - SANTANDER'],
      ['PITALITO - HUILA', 'PITALITO - HUILA'],
      ['POLO NUEVO - ATLANTICO', 'POLO NUEVO - ATLANTICO'],
      ['POPAYAN - CAUCA', 'POPAYAN - CAUCA'],
      ['PRADERA -VALLE', 'PRADERA -VALLE'],
      ['PUERTO COLOMBIA - ATLANTICO', 'PUERTO COLOMBIA - ATLANTICO'],
      ['PUERTO LOPEZ - META', 'PUERTO LOPEZ - META'],
      ['PUERTO LEGUIZAMO - PUTUMAYO', 'PUERTO LEGUIZAMO - PUTUMAYO'],
      ['GRANADA - META', 'GRANADA - META'],
      ['PUERTO TEJADA - CAUCA', 'PUERTO TEJADA - CAUCA'],
      ['QUIBDO - CHOCO', 'QUIBDO - CHOCO'],
      ['QUIMBAYA - QUINDIO', 'QUIMBAYA - QUINDIO'],
      ['QUINCHIA - RISARALDA', 'QUINCHIA - RISARALDA'],
      ['RESTREPO - META', 'RESTREPO - META'],
      ['RICAURTE - CUNDINAMARCA', 'RICAURTE - CUNDINAMARCA'],
      ['RIOHACHA - GUAJIRA', 'RIOHACHA - GUAJIRA'],
      ['RIONEGRO - ANTIOQUIA', 'RIONEGRO - ANTIOQUIA'],
      ['RIOSUCIO - CALDAS', 'RIOSUCIO - CALDAS'],
      ['RISARALDA - CALDAS', 'RISARALDA - CALDAS'],
      ['RIVERA - HUILA', 'RIVERA - HUILA'],
      ['SABANAGRANDE - ATLANTICO', 'SABANAGRANDE - ATLANTICO'],
      ['SABANALARGA - ATLANTICO', 'SABANALARGA - ATLANTICO'],
      ['SABANETA - ANTIOQUÍA', 'SABANETA - ANTIOQUÍA'],
      ['SAN ANDRES - SAN ANDRES', 'SAN ANDRES - SAN ANDRES'],
      ['SAN GIL - SANTANDER', 'SAN GIL - SANTANDER'],
      ['SAN JOSE DE RISARALDA - CALDAS', 'SAN JOSE DE RISARALDA - CALDAS'],
      ['SAN JOSE DEL GUAVIARE - GUAVIARE', 'SAN JOSE DEL GUAVIARE - GUAVIARE'],
      ['SAN PEDRO - ANTIOQUÍA', 'SAN PEDRO - ANTIOQUÍA'],
      ['SANTA MARTA - MAGDALENA', 'SANTA MARTA - MAGDALENA'],
      ['SANTA ROSA DE CABAL - RISARALDA', 'SANTA ROSA DE CABAL - RISARALDA'],
      ['SANTA ROSA DE VITERBO - BOYACA', 'SANTA ROSA DE VITERBO - BOYACA'],
      ['SANTANDER DE QUILICHAO - CAUCA', 'SANTANDER DE QUILICHAO - CAUCA'],
      ['SANTO TOMAS - ATLANTICO', 'SANTO TOMAS - ATLANTICO'],
      ['SANTUARIO - ANTIOQUÍA', 'SANTUARIO - ANTIOQUÍA'],
      ['SEVILLA- VALLE', 'SEVILLA- VALLE'],
      ['SIBATE - CUNDINAMARCA', 'SIBATE - CUNDINAMARCA'],
      ['SIMIJACA - CUNDINAMARCA', 'SIMIJACA - CUNDINAMARCA'],
      ['SINCELEJO - SUCRE', 'SINCELEJO - SUCRE'],
      ['SIBUNDOY - PUTUMAYO', 'SIBUNDOY - PUTUMAYO'],
      ['SOACHA - CUNDINAMARCA', 'SOACHA - CUNDINAMARCA'],
      ['SOGAMOSO - BOYACA', 'SOGAMOSO - BOYACA'],
      ['SOLEDAD - ATLANTICO', 'SOLEDAD - ATLANTICO'],
      ['SOPO - CUNDINAMARCA', 'SOPO - CUNDINAMARCA'],
      ['TABIO - CUNDINAMARCA', 'TABIO - CUNDINAMARCA'],
      ['TENA - CUNDINAMARCA', 'TENA - CUNDINAMARCA'],
      ['TIMBIO - CAUCA', 'TIMBIO - CAUCA'],
      ['TOCANCIPA - CUNDINAMARCA', 'TOCANCIPA - CUNDINAMARCA'],
      ['TRUJILLO - VALLE', 'TRUJILLO - VALLE'],
      ['TULUA - VALLE', 'TULUA - VALLE'],
      ['TUMACO - NARIÑO', 'TUMACO - NARIÑO'],
      ['TUNJA - BOYACA', 'TUNJA - BOYACA'],
      ['TUQUERRES - NARIÑO', 'TUQUERRES - NARIÑO'],
      ['TURBACO - BOLIVAR', 'TURBACO - BOLIVAR'],
      ['TUTAZA - BOYACA', 'TUTAZA - BOYACA'],
      ['UBATE - CUNDINAMARCA', 'UBATE - CUNDINAMARCA'],
      ['VALLEDUPAR - CESAR', 'VALLEDUPAR - CESAR'],
      ['VENTAQUEMADA - BOYACA', 'VENTAQUEMADA - BOYACA'],
      ['VIJES - VALLE', 'VIJES - VALLE'],
      ['VILLA DEL ROSARIO - N. DE SANTANDER', 'VILLA DEL ROSARIO - N. DE SANTANDER'],
      ['VILLAVICENCIO - META', 'VILLAVICENCIO - META'],
      ['YOPAL - CASANARE', 'YOPAL - CASANARE'],
      ['YOTOCO - VALLE', 'YOTOCO - VALLE'],
      ['YUMBO - VALLE', 'YUMBO - VALLE'],
      ['ZARZAL - VALLE', 'ZARZAL - VALLE'],
      ['ZIPAQUIRA - CUNDINAMARCA', 'ZIPAQUIRA - CUNDINAMARCA'],
      ['VILLA DE LEYVA – BOYACÁ', 'VILLA DE LEYVA – BOYACÁ'],
      ['PAIPA – BOYACÁ', 'PAIPA – BOYACÁ'],
      ['VIANI – CUNDINAMARCA', 'VIANI – CUNDINAMARCA'],
      ['MEDINA – CUNDINAMARCA', 'MEDINA – CUNDINAMARCA'],
      ['CHAGUANI – CUNDINAMARCA', 'CHAGUANI – CUNDINAMARCA'],
      ['TIBACUY – CUNDINAMARCA', 'TIBACUY – CUNDINAMARCA'],
      ['LEJANIAS – META', 'LEJANIAS – META'],
      ['PLANADAS – TOLIMA', 'PLANADAS – TOLIMA'],
      ['VILLARRICA – TOLIMA', 'VILLARRICA – TOLIMA'],
      ['DOLORES - TOLIMA', 'DOLORES - TOLIMA'],
      ['MAGANGUE - BOLIVAR', 'MAGANGUE - BOLIVAR'],
      ['TURBACO - BOLIVAR', 'TURBACO - BOLIVAR'],
      ['TIERRALTA - CORDOBA', 'TIERRALTA - CORDOBA'],
      ['RIONEGRO - SANTANDER', 'RIONEGRO - SANTANDER']
    ]
  end

  def select_estadogps
    [['DOCUMENTACION PENDIENTE', 'DOCUMENTACION PENDIENTE'], ['EN PROCESO', 'EN PROCESO'], %w[CERRADO CERRADO]]
  end

  def select_estadodentix
    [['VIGENTE', 'VIGENTE'], ['POR VENCER', 'POR VENCER'], ['VENCIDO', 'VENCIDO'], ['CERRADA', 'CERRADA'], ['TODOS', 'TODOS']]
  end

  def select_estadootros
    [%w[PENDIENTE PENDIENTE], %w[ASIGNADA ASIGNADA], %w[CERRADA CERRADA]]
  end

  def select_formaregistrogps
    [%w[VERBAL VERBAL], %w[FISICA FISICA], %w[EMAIL EMAIL], ['REDES SOCIALES', 'REDES SOCIALES']]
  end

  def select_formaregistro
    [%w[VERBAL VERBAL],
     ['RADICACION INTERNA', 'FISICA'],
     %w[EMAIL EMAIL],
     ['PORTAL WEB', 'PLATAFORMA'],
     ['REDES SOCIALES', 'REDES SOCIALES'],
     ['LINEA ETICA', 'LINEA ETICA'],
     ['BUZON PQRS', 'BUZON PQRS'],
     ['ATENCION AL CLIENTE', 'ATENCION AL CLIENTE'],
     ['TRASLADO ORIGINADOR', 'TRASLADO ORIGINADOR'],
     ['DIRECCION JURIDICA', 'DIRECCION JURIDICA'],
     ['RADICACION INTERNA', 'RADICACION INTERNA']]
  end

  def select_gpsclasificacion
    [%w[ESTUDIO ESTUDIO], %w[AGENCIA AGENCIA]]
  end

  def select_estado_centrales
    [
      %w[ACTIVO ACTIVO],
      %w[BLOQUEADO BLOQUEADO],
      %w[ELIMINADO ELIMINADO]
    ]
  end

  def select_instancia_gasto
    [
      ['REPORTING FIDEICOMISO', 'REPORTING FIDEICOMISO'],
      ['REPORTING PACKAGE GS1/GS2', 'REPORTING PACKAGE GS1/GS2'],
      %w[GPS GPS]
    ]
  end

  def select_estado_reclamaciones
    [
      ['EN PROCESO', 'EN PROCESO'],
      ['RADICADA', 'RADICADA'],
      ['OBJETADO', 'OBJETADO'],
      ['EN FIRME', 'EN FIRME'],
      ['PAGADA', 'PAGADA']
    ]
  end

  def select_estadoreclamacionesgarantia
    [
      ['PENDIENTE', 'PENDIENTE'],
      ['APROBADA', 'APROBADA'],
      ['RECHAZADA', 'RECHAZADA']
    ]
  end

  def select_bancogps
    [
      %w[BBVA BBVA],
      %w[BCP BCP]
    ]
  end

  def select_interescorriente
    [
      ['SI', -1],
      ['NO', 0]
    ]
  end

  def select_result
    [
      ['AWARDED BY 3RD PARTY', 'AWARDED BY 3RD PARTY'],
      ['AWARDED BY GS', 'AWARDED BY GS'],
      ['NO BIDDERS', 'NO BIDDERS'],
      %w[RE-SCHEDULED RE-SCHEDULED],
      %w[SUSPENDED SUSPENDED],
      %w[PENDING PENDING]
    ]
  end

  def select_tiporegistro
    [
      %w[ABONO A],
      %w[DOCUMENTO D]
    ]
  end

  def select_tiposdocumentosreo
    [
      %w[FACTURA F],
      %w[BOLETA B],
      %w[RECIBO R],
      %w[COMPROBANTE C],
      ['FACTURA SIN DETRACCION', 'FSD']
    ]
  end

  def select_ubicaciongasto
    [
      %w[RECAUDO REC],
      %w[GASTO GAS]
    ]
  end

  def select_tiposdocumentosreon
    [
      ['FACTURA DEL PROVEEDOR', 'F'],
      ['NOTA CRÉDITO PROVEEDOR', 'N'],
      ['NOTA DÉBITO PROVEEDOR', 'C'],
      ['FACTURA DE LA EMPRESA', 'E'],
      ['NOTA CRÉDITO EMPRESA', 'M'],
      ['NOTA DÉBITO EMPRESA', 'B'],
      %w[COBRANZA Z],
      %w[OTROS D]
    ]
  end

  def select_carguegastos
    [
      ['GASTOS PROCESALES BCP', 'GASTOS PROCESALES'],
      ['GASTOS PROCESALES BBVA', 'GASTOS BBVA'],
      ['GASTOS PROCESALES BBVA-CC', 'GASTOS BBVA-CC'],
      ['GASTOS REO', 'GASTOS REO'],
      ['RESPUESTA BCP', 'RESPUESTA BCP'],
      ['RESPUESTA BBVA', 'RESPUESTA BBVA'],
      ['RESPUESTA REO', 'RESPUESTA REO'],
      ['SOPORTE DIGITAL', 'SOPORTE DIGITAL']
    ]
  end

  def select_tipocuentaproveedor
    [
      %w[CORRIENTE C],
      %w[MAESTRA M],
      %w[AHORROS A],
      %w[INTERBANCARIA B]
    ]
  end

  def select_claseimagenhipo
    [
      %w[IMAGEN IMAGEN],
      %w[MAPA MAPA]
    ]
  end

  def select_physical_rating
    [
      ['A+', 'A+'],
      %w[A A],
      ['A-', 'A-'],
      ['B+', 'B+'],
      %w[B B],
      ['B-', 'B-'],
      ['C+', 'C+'],
      %w[C C],
      ['C-', 'C-']
    ]
  end

  def select_location_rating
    [
      ['A+', 'A+'],
      %w[A A],
      ['A-', 'A-'],
      ['B+', 'B+'],
      %w[B B],
      ['B-', 'B-'],
      ['C+', 'C+'],
      %w[C C],
      ['C-', 'C-']
    ]
  end

  def select_efectivanoefectiva
    [
      %w[EFECTIVA EFECTIVA],
      ['NO EFECTIVA', 'NO EFECTIVA']
    ]
  end

  def select_dentixprioridad
    [
      ['PRIORIDAD 1', 'PRIORIDAD 1'],
      ['PRIORIDAD 2', 'PRIORIDAD 2'],
      ['PRIORIDAD 3', 'PRIORIDAD 3'],
      ['PRIORIDAD 4', 'PRIORIDAD 4']
    ]
  end

  def select_codigoestado
    [
      ['1', 1],
      ['2', 2],
      ['3', 3],
      ['4', 4],
      ['5', 5]
    ]
  end

  def select_portafolio
    [
      %w[BBVA1 BBVA1],
      %w[BBVA2 BBVA2],
      %w[GSBBVA2 GSBBVA2],
      %w[GSBBVA1 GSBBVA1],
      %w[BCP1 BCP1],
      %w[BCP2 BCP2],
      ['BBVA I', 'BBVA I']
    ]
  end

  def select_originadorinmueble
    [
      %w[BCP BCP],
      %w[BBVA BBVA]
    ]
  end

  def select_patrimonio
    [
      ['REO TRUST 2016', 'REO TRUST 2016'],
      ['CUSCO 2018', 'CUSCO 2018'],
      ['LOAN TRUST 2019', 'LOAN TRUST 2019']
    ]
  end

  def select_tipopatrimonio
    [
      %w[INGRESOS INGRESOS],
      %w[GASTOS GASTOS]
    ]
  end

  def select_tipo_cierre
    [
      %w[GENERAR GENERAR],
      %w[CONSOLIDAR CONSOLIDAR]
    ]
  end

  def select_tipodocumentoinmueble
    [
      ['SITE INSPECTIONS', 'SITE INSPECTIONS'],
      ['DOCUMENTOS MUNICIPALES', 'DOCUMENTOS MUNICIPALES'],
      %w[RRPP RRPP],
      ['COMPRA VENTA', 'COMPRA VENTA'],
      ['DOCUMENTOS DE CRÉDITO', 'DOCUMENTOS DE CRÉDITO'],
      %w[FOTOS FOTOS],
      %w[UBICACIÓN UBICACIÓN]
    ]
  end

  def select_estado_bloqueo
    is_select_estado_bloqueo
  end

  def select_mesanno
    [
      ['2019/01', '2019/01'], ['2019/02', '2019/02'], ['2019/03', '2019/03'], ['2019/04', '2019/04'], ['2019/05', '2019/05'], ['2019/06', '2019/06'], ['2019/07', '2019/07'], ['2019/08', '2019/08'], ['2019/09', '2019/09'], ['2019/10', '2019/10'], ['2019/11', '2019/11'], ['2019/12', '2019/12'],
      ['2020/01', '2020/01'], ['2020/02', '2020/02'], ['2020/03', '2020/03'], ['2020/04', '2020/04'], ['2020/05', '2020/05'], ['2020/06', '2020/06'], ['2020/07', '2020/07'], ['2020/08', '2020/08'], ['2020/09', '2020/09'], ['2020/10', '2020/10'], ['2020/11', '2020/11'], ['2020/12', '2020/12'],
      ['2021/01', '2021/01'], ['2021/02', '2021/02'], ['2021/03', '2021/03'], ['2021/04', '2021/04'], ['2021/05', '2021/05'], ['2021/06', '2021/06'], ['2021/07', '2021/07'], ['2021/08', '2021/08'], ['2021/09', '2021/09'], ['2021/10', '2021/10'], ['2021/11', '2021/11'], ['2021/12', '2021/12'],
      ['2022/01', '2022/01'], ['2022/02', '2022/02'], ['2022/03', '2022/03'], ['2022/04', '2022/04'], ['2022/05', '2022/05'], ['2022/06', '2022/06'], ['2022/07', '2022/07'], ['2022/08', '2022/08'], ['2022/09', '2022/09'], ['2022/10', '2022/10'], ['2022/11', '2022/11'], ['2022/12', '2022/12']
    ]
  end

  def select_tipotoma
    [
      %w[VOLUNTARIA VOLUNTARIA],
      %w[LANZAMIENTO LANZAMIENTO]
    ]
  end

  def select_tipogasto
    [
      %w[BCP BCP],
      %w[BBVA BBVA]
    ]
  end

  def select_tiporecfit
    [
      ['RECAUDOS FIT', 'RECAUDOS FIT'],
      ['CAJA SULLANA', 'CAJA SULLANA'],
      ['CAJA HUANCAYO', 'CAJA HUANCAYO']
    ]
  end

  def select_gpsconformidad
    [
      ['SIN CONFORMIDAD', 'SIN CONFORMIDAD'],
      %w[GPS GPS]
    ]
  end

  def select_etapareportes
    [
      %w[RECAUDOS C],
      %w[GESTION D],
      ['OTROS INFORMES', 'F'],
      %w[COMISIONES G],
      %w[TABLAS B],
      %w[INMUEBLES I],
      ['PROCESOS JURIDICOS', 'J'],
      ['CARTERA CIERRES', 'R'],
      ['CENTRALES DE RIESGO', 'O']
    ]
  end

  def select_tipocifin
    [
      %w[cifin_cct cifin_cct],
      %w[cifin_ctc cifin_ctc]
    ]
  end

  def select_materias
    [
      %w[PENDIENTE PENDIENTE],
      %w[PENDIENTE PENDIENTE],
      %w[PENDIENTE PENDIENTE]
    ]
  end

  def informesportafolios
    [
      %w[portafoliossucursales Sucursales],
      %w[portafolioscuentas Cuentas],
      %w[portafoliosvehiculos Vehiculos],
      %w[portafolioscontrato Contratos],
      %w[clientes Originadores],
      ['portafoliostasas', 'Tasas Mora'],
      %w[municipios Municipios]
    ]
  end

  def select_formaregistro2
    [
      %w[VERBAL VERBAL],
      %w[FISICA FISICA],
      %w[EMAIL EMAIL],
      ['REDES SOCIALES', 'REDES SOCIALES']
    ]
  end

  def select_estadosistem
    [
      %w[ASIGNADA ASIGNADA],
      %w[CERRADA CERRADA],
      ['EN PROCESO', 'EN PROCESO'],
      ['MARCACION BASE', 'MARCACION BASE'],
      ['GESTION FINALIZADA PARCIAL', 'GESTION FINALIZADA PARCIAL'],
      ['GESTION FINALIZADA TOTAL', 'GESTION FINALIZADA TOTAL'],
      %w[PENDIENTE PENDIENTE]
    ]
  end

  def select_estadoampliacion
    [
      %w[APROBADO APROBADO],
      %w[RECHAZADO RECHAZADO]
    ]
  end

  # SELECTS TO GPS SENSIBLES

  def select_codigosensible
    [
      ['Low income', 'Low income'],
      ['Other special family circunstances', 'Other special family circunstances'],
      ['Insurance claim pending', 'Insurance claim pending'],
      ['Limited financial sophistication', 'Limited financial sophistication'],
      ['Physical disability', 'Physical disability'],
      ['Mental Illness', 'Mental Illness'],
      ['Learning disability', 'Learning disability'],
      ['Terminal Illness', 'Terminal Illness'],
      %w[Addiction Addiction],
      ['Under bereavement', 'Under bereavement'],
      ['Domestic violence', 'Domestic violence'],
      ['Suicide threats', 'Suicide threats'],
      ['Reputational concerns', 'Reputational concerns'],
      %w[Age Age]
    ]
  end

  def select_fuentedetenccion
    [
      ['Gestión de cobranza', 'Gestión de cobranza'],
      ['Propuesta de pago', 'Propuesta de pago'],
      %w[Remate Remate]
    ]
  end

  def select_borrower
    [
      %w[Performing Performing],
      %w[Mix-Performing Mix-Performing],
      %w[Legal Legal],
      %w[Resolved Resolved]
    ]
  end

  def select_loanstatus
    [
      ['90 DPD', '90 DPD'],
      %w[Performing Performing],
      %w[Resolved Resolved]
    ]
  end

  def select_casosensible
    [
      %w[Y Y],
      %w[N N]
    ]
  end

  def select_acuerdosmetodocambio
    [
      ['EXTENSION PLAZO', 'EXTENSION PLAZO'],
      ['CONTRACCION PLAZO', 'CONTRACCION PLAZO']
    ]
  end

  def select_lote
    [
      ['1', 1],
      ['2', 2],
      ['3', 3],
      ['4', 4],
      ['5', 5],
      ['6', 6]
    ]
  end

  def select_sistema_amortiza
    [
      ['CUOTA CONSTANTE MF', 'CUOTA CONSTANTE MF'],
      ['CUOTA CONSTANTE MS', 'CUOTA CONSTANTE MS'],
      ['ABONO CONSTANTE CAPITAL', 'ABONO CONSTANTE CAPITAL'],
      ['CUOTA ESCALONADA', 'CUOTA ESCALONADA'],
      ['CUOTA COMODIN', 'CUOTA COMODIN'],
      ['CUOTA BALLOON', 'CUOTA BALLOON'],
      ['PLAN DE PAGOS FLEXIBLE', 'PLAN DE PAGOS FLEXIBLE']
    ]
  end

  def select_sistema_amortiza_2
    [
      #['ABONO CONSTANTE CAPITAL', 'ABONO CONSTANTE CAPITAL'],
      ['CUOTA CONSTANTE FACTOR', 'CUOTA CONSTANTE FACTOR']
    #  ['CUOTA COMODIN', 'CUOTA COMODIN'],
      #  ['CUOTA BALLON', 'CUOTA BALLON']
    ]
  end

  def select_tipo_notificacion(estado)
    if estado == 'CERRADA'

      [
        ['NOTIFICACION ALCANCE', 'NOTIFICACION ALCANCE'],
        ['NOTIFICACION TRASLADO', 'NOTIFICACION TRASLADO']
      ]
    else
      [
        ['NOTIFICACION RESPUESTA', 'NOTIFICACION RESPUESTA']
      ]
    end
  end

  def select_clasedocumento
    [
      %w[PDF application/pdf],
      %w[JPG image/jpeg]
    ]
  end

  def select_portafoliosvehiculos
    is_select_portafoliosvehiculos
  end

  def select_adjetivo
    [
      ['NO ADJETIVO RELACIONADO', '0'],
      ['FALLECIDO', '1'],
      ['DEUDOR NO LOCALIZADO', '2'],
      ['CUENTA EN COBRADOR', '3'],
      ['LINEA DESCONECTADA', '4'],
      ['INCAPACIDAD TOTAL O PERMANENTE', '5'],
      ['COBRO PREJURIDICO', '6'],
      ['COBRO JURIDICO', '7']
    ]
  end

  def fix_url(url)
    if url
      url.empty? ? '#' :
        url.include?('://') || url.start_with?('/') ? url : "http://#{url}"
    end
  end

  def select_periodo_convocatorias
    [
      ["01", "01"],
      ["02", "02"]
    ]
  end

  def select_tipooblcrearedu
    [
      ["PIN", "PIN"],
      ["INSCRIPCIÓN", "INSCRIPCION"]
    ]
  end

  def select_convocatoria_descripcion
    if is_aplicacion == 10100
      [["NO FORMAL", "NO FORMAL"], ["POSGRADO", "POSGRADO"], ["BLOQUE B", "BLOQUE B"], ["C2", "C2"], ["C3", "C3"]]
    else
      [["POSGRADO", " POSGRADO"], ["B POSGRADO", "B POSGRADO"]]
    end
  end

  def select_tipo_dato_webservice
    [
      ["TEXTO", "varchar(255)"],
      ["NUMERICO", "number(38)"],
      ["DECIMAL", "number(38,2)"],
      ["FECHA", "date"]
    ]
  end

  def select_parorigenespagos
    is_select_parorigenespagos
  end

  def select_parorigenespagos_ajuste
    is_select_parorigenespagos_ajuste
  end

  def descripcion_columna1_p3(params)
    case params
    when 10348
      'Empresa'
    when 10040
      'Aseguradora'
    else
      'Portafolio'
    end
  end

  def descripcion_columna2_p3(params)
    case params
    when 10348
      'Información'
    else
      'Contadores'
    end
  end

  def columns_type_form(attribute)
    Queja.column_for_attribute(attribute.campo).type == :inet ? :string : Queja.column_for_attribute(attribute.campo).type
  end

  def columns_type_size(attribute)
    if [:string].include?(columns_type_form(attribute))
      '4'
    elsif [:integer, :date].include?(columns_type_form(attribute))
      '2'
    elsif [:text].include?(columns_type_form(attribute))
      '6'
    end
  end

  def descripcion_modulo(modulo)
    "<a data-toggle='tooltip' data-remote='true' data-original-title='#{texto_informacion_modulo(modulo)}'><span class='badge bg-primary'><i class='fa fa-info-circle'></i></span></a>".html_safe
  end

  def texto_informacion_modulo(modulo)
    if modulo == 'carguemasivopqrs'
      '** .Si se selecciona la opcion - SI - el sistema toma todas las pqrs que cuentan con una asignacion de usuario, si se selecciona - NO - El sistema toma todas las pqrs que no cuentan con usuario asignado - Si se deja Vacio el sistema toma todas las pqrs que esten asignada y no asignadas.'
    elsif modulo == 'tasacambio'
      '** La tasa de cambio no se encuentra parametrizada.'
    elsif modulo == 'preaviso'
      '** La fecha de preaviso se calcula después de guardar en el sistema'
    elsif modulo == 'vlr_iva'
      '** El Valor Iva se calcula después de guardar en el sistema'
    elsif modulo == 'fecha_fin_contratos'
      '** La Fecha Fin se calcula despues de guardar en el sistema'
    end
  end

  def select_incremento_contratos
    [
      ['IPC', 'IPC'],
      ['IPC MAS SPREED', 'IPC MAS SPREED'],
      ['PORCENTAJE', 'PORCENTAJE'],
      ['VALOR FIJO', 'VALOR FIJO']
    ]
  end

  def select_dias_plazo(personascontrato, datoinicial)
    personascontrato.plazo
    inicial = personascontrato.personasconcannones.minimum("cuota_inicial")  rescue 0
    final = personascontrato.personasconcannones.maximum("cuota_final").to_i rescue 0
    dato2 = []
    i = datoinicial
    if inicial.present? && final.present?
      while i <= personascontrato.plazo
        if i >= inicial && i <= final
        else
          dato2 << ["#{i}", "#{i}"]
        end
        i = i + 1
      end
    else
      while i <= personascontrato.plazo
        dato2 << ["#{i}", "#{i}"]
        i = i + 1
      end
    end
    dato2
  end

  def aplica_mora_contrato
    [
      ["MAXIMA LEGAL", -1],
      ["OTRA", -2],
      ["NO APLICA", 0]
    ]
  end
end
