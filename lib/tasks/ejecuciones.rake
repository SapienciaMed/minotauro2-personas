namespace :ejecuciones do
  task ejecucionesrake: :environment do
    Ejecucion.ejecrake
  end
end

