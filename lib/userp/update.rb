module Userp
  module Update

    def one
      personas = Persona.where(portafolio_id: 10100).select(:identificacion)
      personas.each do |p|
        tieneconvenios = Conveniospermitido.where(identificacion: p.identificacion).collect(&:convenio_id) rescue nil 
        conveniosids = [7,16,17,14,87]
        if tieneconvenios.sort != (conveniosids.sort)
          faltaconvenios = conveniosids.sort - tieneconvenios.sort
          faltaconvenios.each do |c|
            conveniospermitido = nil
            conveniospermitido = Conveniospermitido.new
            conveniospermitido.identificacion = p.identificacion
            conveniospermitido.convenio_id = c
            conveniospermitido.estado = 'ACTIVO'
            conveniospermitido.save(validate: false)
          end
        end
      end
    end

    def two 
      personas = Persona.where("portafolio_id = 10101 and autobuscar is null")
      personas.each do |p|
        p.antesdeguardar
        p.save(validate: false)
      end
    end 

    def three
      imagenes = Personasprogimagen.where("programa_file_name like 'foto%' and programa_file_name not like '%jpg' and programa_file_name not like '%jpeg' and programa_file_name not like '%JPG' and programa_file_name not like '%pdf' and programa_file_name not like '%png' and programa_file_name not like '%PNG' and programa_file_name not like '%docx' and programa_content_type not like '%document'")
      imagenes.count
      imagenes.each do |img|
        img.programa_file_name = img.programa_file_name + '.' +img.programa_content_type.split('/').last
        img.save(validate: false)
      end 
    end

    def four
      imagenes = Personasprogimagen.where("id in (199291,198521,198613,198793,198979,199311,199313,199337,199338,197055,197061,197140,197308,197316,198888,199021,199043,199061,196954,197023,197271,197022,197093,197422,197430,197461,197473,197907,197929,198754,198764,198806,198807,198817,198884,198953,199118,199126,199161,199174,199191,199250,199319,198997,199013,199064,199229,199238,198585,198619,198647,198686,196834,197186,197290,197249,197254,197415,197423,197428,198607,198919,197136,197148,198850,198881,197107,197225,197228,197383,197392,197406,197272,197941,197955,197947,197205,198507,198523)")
      imagenes.each do |img|
        if img.programa_content_type.split('/').last == 'jpeg'
          img.programa_file_name = img.programa_file_name.split('.').first
        else
          img.programa_file_name = img.programa_file_name.split('.').first
        end
        img.save(validate: false)
      end
    end
  end 
end