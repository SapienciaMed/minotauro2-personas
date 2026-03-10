Rails.application.routes.draw do

  resources :ejecuciones
  resources :archivos do
    collection do
      get 'get_tipoproceso'
      get 'uploadctl'
      get 'download_ctl'
      get 'cargues'
      get 'headxls'
      get 'inconsistenciasgen'
    end
  end

  resources :migracioneslinks do
    collection do
      get 'cargar'
    end
  end

  resources :moduloscampos

  resources :infgruposcampos
  resources :infgrupos

  resources :personasoblcrespaldos
  resources :personasoblrecibos do
    collection do
      get :generador
      get :search
      get :get_personasoblrecibo_personasobligacion_id
    end
  end

  get '/links', to: "epayco#links"


  resources :personasoblcambios do
    collection do
      get :cambioestado
    end
  end

  resources :migracionescreditos
  resources :personasdemograficos
  resources :tasassimulaciones
  resources :desembolsossimulaciones

  resources :desembolsospersonas do
    collection do
      get :informe
    end
    resources :desembolsos
    resources :desembolsosrelaciones
  end

  resources :desembolsosrelaciones do
    resources :desembolsoscreditos
  end

  resources :desembolsoscreditos
  resources :desembolsosrelaciones
  resources :desembolsos do
    collection do
      get :visualizar
    end
  end

  resources :tiposcontroles
  resources :convocatoriasdocumentos

  resources :convocatorias do
    collection do
      get :buscar
    end
  end

  resources :personasalisbienes do
     resources :personasalisbimagenes
  end

  resources :personasalislaborales do
     resources :personasalislimagenes
  end

  resources :personasalisasociados do
     resources :personasalisaimagenes
  end

  resources :notarias
  resources :oficinas
  resources :municipios
  resources :oficinasregistros

  resources :personasalistamientos do
    collection do
      get :cargagestiones
      get :cartam
      get :notificacionactrealizada
      get :buscar
      get :buscarx
      get :busqueda
      get :visualizar
    end
    resources :personasalisbienes
    resources :personasalislaborales
    resources :personasalisasociados
  end

  resources :reportes do
    collection do
      get :indexpac
      get :controles
      get :portafolio
      get :informedemografico
      get :infoevolucionrecaudo
      get :infoconsola
      get :infoorigen
      get :infoamorti
      get :infoasigna
      get :inforeca
      get :inforecaacum
    end
  end

  resources :tiposestados
  resources :datagiros
  resources :datacomfamas
  resources :recordaciones
  resources :informescontables

  resources :bancorecaudos do
    collection do
      get :cargar3
      get :cargar
      get :import
      get :cargarAsobancaria
    end
  end

  resources :comites do
    collection do
      get :aprobarmasiva
      get :cargagestiones
      get :cartam
      get :notificacionactrealizada
      get :buscar
      get :buscarx
      get :busqueda
      get :visualizar
    end
    resources :comitessolicitudes
    resources :comitesusers
    resources :comitesobservaciones
    resources :comitesimagenes
  end

  resources :actas

  resources :solicitudes do
    collection do
      get :actdatos
      get :updatedatos
      get :visualizar
      get :visualizarcomite
      get :update2
      get :activar
    end
    resources :solicitudesobservaciones
  end

  resources :planessimulaciones do
    collection do
      get :restruct
    end
  end

  resources :planesfacturas do
    collection do
      get :detalle
    end
  end
  resources :parametros
  resources :historicostasasusuras
  resources :historicostasas
  resources :planesrespaldos

  resources :procesos do
    collection do
      get :sygma_infrecconsol
      get :sygma_infrecdetallados
      get :sygma_infobservaciones
      get :sygma_infestadocontable
      get :sygma_costoamortizado
      get :sygma_costodamortizado
      get :sygma_infdavivienda
      get :sygma_informecartera
      get :sygmadownload
      get :sygmarchivo
      get :sygma_infcontrol
      get :import
      get :solicitudes
      get :creditos
      get :importcreditos
      get :asesores
      get :importasesores
      get :morafecha
      get :procesofactura
      get :param
      get :reversar
      get :recaudo
      get :mora
      get :busqueda
    end
  end

  resources :controles do
    collection do
      get :publicacion
      get :acta1
      get :acta2
      get :acta3
    end
  end

  resources :personasprocesos do
    collection do
      get :carta
      get :cartam
    end
    resources :personasproimagenes
  end

  ########################################
  #   BIOCREDIT
  # ######################################

  get '/ws_token_biocredit', to: "ws#tokenBioCredit"
  post '/ws_universal', to: "api#ws_universal"

  get '/searchtelefonica', to: "personasoblconsultas#indextelefonica"

  resources :personasoblconsultas do
    collection do
      get :resultado
      get :indextelefonica
      post :respuesta
      post :pagoespecial
    end
  end
  resources :sygmausers
  resources :personaseducorreos do
    collection do
      get :descargar
      get :vertodo
      post :envio
    end
  end

  resources :planeshobligaciones
  resources :clasedocconvenios
  resources :buscadorsegpersonas
  get '/ws_token', to: "ws#tokensiigo"
  get '/wstoken', to: "ws#pedir_token"
  get '/wsreguser', to: "ws#registro_persona"
  get '/ws_sftp', to: "ws#sftpgps"

  post '/pago_epayco_ws', to: 'ws#epayco_webhook', as: :pago_epayco_ws

  resources :ws do
    collection do
      get  :pedir_token
      get  :tokensiigo
      get  :registro_persona
      post :confirmacion
      get  :confirmaciontest
      get  :sftpgps
      get  :sftpgps_test
      get  :tokenBioCredit
      get  :wsCreateData
      get  :wsApiget

      post :pago_paymentez
      post :pago_epayco
      post :paymentez_webhook

      # 🔥 CLAVE: permitir GET y POST
      post :epayco_webhook
      get  :epayco_webhook

      post :toke_notificacion_vardi
      post :notificacion_pago_paymentez_vardi
    end
  end


  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  match '/well_known', to: redirect('/.well-known/pki-validation/godaddy.html'), via: [:get]

  match "/404", to: "errors#not_found", via: :all
  match "/402", to: "errors#blank_page", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  get "/422", :to => "errors#error_404"
  get "/505", :to => "errors#error_505"

  scope "/admin" do
    resources :audits do
      collection do
        get 'busqueda'
      end
    end
    resources :usersactivos do
      collection do
        get 'cerrarsesion'
      end
    end
  end

  devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users_controller' }

  devise_scope :user do
    scope :users, as: :users do
      get 'pre_otp', to: 'users/sessions#pre_otp'
    end

    post "autenticacion_token", to: "users/sessions#autenticacion_token"
    post "/users/sessions/verify_otp" => "users/sessions#verify_otp"

    authenticated :user do
      root 'menus#index'
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end

    put 'users' => 'devise/registrations#update', as: 'user_registration'
    get 'users/edit' => 'devise/registrations#edit', as: 'edit_user_registration'
    delete 'users' => 'devise/registrations#destroy', as: 'registration'
    get 'logout' => 'devise/sessions#destroy'
  end

  resources :two_factor do
    collection do
      get :activate
      get :deactivate
      get :final
      get :recaptcha
      get :recaptcha_session
    end
  end

  resources :planesarechonorarios
  resources :planesarecaudosdetalles

  get 'personas/index'
  get '/checkedupol', to: "procesos#validacionedupol"

  resources :planesobligaciones do
    collection do
      get 'detalle'
      get 'cambioplan'
    end
  end

  resources :personas do
    get :autocomplete_persona_autobuscar, on: :collection
    get :autocomplete_municipio_autobuscar, on: :collection

    collection do
      get 'search_persona'
      post 'destroyreg'
      get 'extractoindividual'
      get 'validaenvio'
      get 'direccion'
      get 'update_direccion'
      get 'search'
      get 'bodegapersona'
      get 'verconsolestudiante'
      get 'edupolresetpass'
      get 'datosprimarios'
      get 'vistaedupol'
      get 'vistaedupolexcel'
      get 'buscarjuridico'
      get 'get_persona_tiposdiscapacidades'
      get 'get_persona_clasesetnias'
      get 'vistaexcelgca'
      get 'vistagca'
      get 'borrarprogramacion'
      get 'redis'
      get 'cambiarestadogca'
      get 'viewspecial'
      get 'viewspecial_a'
      get 'viewspecial_b'
      get 'viewspecial_c'
      get 'viewspecial_d'
      get 'web'
      get 'solicitudcomp'
      get 'buscadorprincipal'
      post 'buscarapido'
      get 'searchper'
      get 'vistaexcel'
      get 'asignar'
      get 'programar'
      get 'programarenviocorreo'
      get 'carguepaga'
      get 'informelibranza'
      get 'sendtemp'
      get 'infoevolucionrecaudo'
      get 'uploadfile_bene'
      get 'uploadfile1'
      get 'masivo'
      get 'cargueimg'
      get 'cargueobs'
      get 'proceso'
      get 'informecartera'
      get 'borrarmasivos'
      get 'uploadaprocambios'
      get 'uploadpagares'
      get 'uploadcartainstruccion'
      get 'uploadfactura'
      get 'uploadaprobacion'
      get 'sendaprobacion'
      get 'send2amortizacion'
      get 'sendamortizacion'
      get 'demografico'
      get 'sendnotifiresolucion'
      get 'uploadfile'
      get 'consolidarfactura'
      get 'sendnotificacion'
      get 'procesofactura'
      get 'busqueda'
      get 'buscar'
      post 'vista'
      get 'vista'
      get 'programas'
      get 'etapaf'
      get 'etapar'
      get 'etapare'
      get 'get_persona_comercial_user_id'
      get 'get_persona_amigo_id'
      get 'uploadexpediente'
      get 'uploadcesion'
      get 'uploadcertificado'
      get 'relacionpagos'
      get 'descargarimagenes'
      get 'descargarimagenesportafolio'
      get 'procesocreausers'
      get 'sendpc_masive'
      get 'sendpc'
    end

    resources :personasdirecciones do
      member do
        get 'activo'
        get 'inactivo'
        get 'tercero'
      end
    end
    resources :personastelefonos do
      member do
        get 'activo'
        get 'inactivo'
        get 'tercero'
      end
    end
    resources :personascorreos do
      member do
        get 'activo'
        get 'inactivo'
      end
    end
    resources :personascodeudores
    resources :personasimagenes
    resources :personasobservaciones
    resources :personasacademicos
    resources :personasliquidaciones
    resources :personasgiros
    resources :personasalislaborales
    resources :personasprocesos
    resources :controles
    resources :personascontroles

    resources :personasobligaciones do
      member do
        get 'reaplicarobldatos'
        get 'cambiovalores'
        get 'cambiovalores2'
        get 'certificacionsaldos'
        get 'certificadotributario'
        get 'judicializar'
        get 'eliminarautorizacion'
        get 'autorizaciones'
        get 'progresoprocedimiento'
        get 'fchterminacionpro'
        get 'planpagos'
        get 'ppinicial'
        get 'ppmodificado'
        get 'ppinicialexcel'
        get 'ppmodificadoexcel'
        get 'pagarenro'
        get 'noautorizaventa'
        get 'autorizaventa'
        get 'autoriza'
        get 'noautoriza'
        get 'autorizap'
        get 'noautorizap'
        get 'autorizaa'
        get 'noautorizaa'
        get 'autorizan'
        get 'noautorizan'
        get 'autorizarcifin'
        get 'autorizardatac'
        get 'verdatoscifin'
        get 'verdatosdatac'
        get 'pazysalvo'
        get 'dentix'
        get 'activo'
      end
    end
  end

  resources :personasobligaciones do
    get :autocomplete_personasobligacion_nro_obligacion, on: :collection
    collection do
      get 'download_zip'
      get 'download'
      get 'ver_facturas'
      get 'formato_factura'
      get 'showpazysalvos'
      get 'reaplicarobldatos'
      get 'abri_enviar_pazysalvo'
      get 'enviar_pazysalvo'
      get 'cambiovalores'
      get 'cambiovalores2'
      get 'paymentez_success'
      get 'paymentez_failure'
      get 'paymentez_pending'
      get 'paymentez_review'
      get 'resumen_paymentez'
      get 'generarliquidaciones'
      get 'generarliquidaciones_e'
      get 'pagoespecial'
      get 'rptoblcontrol'
      get 'informeslvigente'
      get 'certificacionsaldos'
      get 'certificadotributario'
      get 'judicializar'
      post :ejecmoramanual
      get 'inforecaudos'
      get 'declaracionrenta'
      get 'predeclaracionrenta'
      get 'moramanual'
      get 'simuladorpago'
      get 'ejecutarsimuladorpago'
      get 'noadeudo'
      get 'noadeudocovinoc'
      get 'noadeudofit'
      get 'liquidaciondeuda'
      get 'certificadodesaldo'
      get 'noadeudointerbank'
      get 'estadodeuda'
      get 'certficadodeudadentix'
      get 'extracto'
      get 'extractosend'
      get 'extractomasive'
      get 'extractosdentix'
      get 'notimoradentix'
      get 'estadodeudacartera'
      get 'informe_recaudos'
      get 'cesion'
      get 'cesionsistem'
      get 'control'
      get 'certificado'
      get 'verpazysalvo'
      get 'vercertificadodedeuda'
      get 'vercertificadodedeuda_xlsx'
      get 'carta'
      get 'pecuniario'
      get 'creditosadicionales'
      get 'creditosadicionalesnuevo'
      get 'cartam'
      get 'historicoasignaciones'
      get :get_personasobligacion_cliente
      get 'noautorizapazysalvo'
      get 'pazysalvoautoriza'
      get 'historico_pagos'
      get 'historico_pagos2'
      get 'historicodetalle_pagos'
      get 'historicodetallesystem'
      get 'historicodetallesysteme'
      get 'pazysalvo'
      get 'pazysalve'
      get 'cambio'
      get 'plan'
    end
    resources :planesrecaudos
    resources :personasoblcambios
  end

  resources :planesrecaudos do
    collection do
      get 'show_detalle'
      post 'superreversion'
      post 'superaplicacion'
      get 'verliquidacion'
      get 'anulacion'
      get 'preparaa'
      get 'cambiotipopago'
      get 'ver'
      get 'prepara'
      get 'extinguir'
      get 'veraplicacion'
      post :reversion
      get 'prereversion'
      get 'preparaajuste'
      get 'ajustar'
      get 'destroyreg'
      get 'cambioiniciocuotas'
      get 'cambiofechainicio'
    end

    resources :planesrecaudosdocs
    resources :planesrecaudosdetalles
    resources :planesarecaudosdetalles
  end

  resources :planespagos

  resources :planes do
    collection do
      get 'param'
      get 'reversar'
      get 'recaudo'
      get 'mora'
      get 'busqueda'
      get 'buscar'
    end
  end

  # chain_selects

  resources :modulos
  resources :objetos

  scope "/admin" do
    resources :users do
      get :autocomplete_identificacion_nombre, on: :collection
      get :autocomplete_cambio_user2, on: :collection
      get :autocomplete_user_nombre, on: :collection
      collection do
        get 'search'
        get 'tabhome'
        get 'resetpass'
        get 'reestablecesusuario'
        post 'cambiousuario'
        get 'cargar'
        get 'cargar2'
        get 'inconsistencias'
        get 'fincargue'
        get 'actemail'
        post 'updateemailedu'
        get 'modogestion'
        get 'modograficoedu'
        get 'desbloquearusuario'
        get 'activaruser'
        get 'inactivaruser'
        post 'cambioportafolio'
        get 'cambiotipoconsulta'
        get 'cambiosucursal'
        get 'cambiarperfil'
        get 'retirarcargos'
        get 'masivo'
        get 'updatepass'
        post 'etapar'
        get 'etapa'
        get 'act'
        get 'edupol_desbloquearusuario'
        get 'carguemasivo'
        post 'importar'
        post 'importar2'
        get 'permisosymodulos'
        get 'generarcuentasdecobre'
        get 'etapabd'
      end
    end
  end


  resources :menus do
    collection do
      post :index
      post :desbloqueoreset
      get :prueba
    end
  end
end
