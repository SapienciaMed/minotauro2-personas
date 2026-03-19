namespace :creacionfactura do
  task creacion_factura: :environment do
    PersonasobligacionesController.generarfactura
  end

  task creacion_factura_test: :environment do
    PersonasobligacionesController.generarfactura_test
  end
end

