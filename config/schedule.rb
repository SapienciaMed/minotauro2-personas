every :day, at: ['10:00 am','2:00 pm','9:30 pm'] do
  rake 'creacionuser:creacion_usuario'
end

every :day, at: ['2:00 am', '6:00 am','10:00 am', '2:00 pm', '6:00 pm', '10:00 pm'] do
  rake 'creacionfactura:creacion_factura'
end

every 2.minute do
  rake 'ejecuciones:ejecucionesrake'
end