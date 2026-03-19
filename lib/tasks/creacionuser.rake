namespace :creacionuser do
  task creacion_usuario: :environment do
    PersonasController.crear_usuario
  end
end