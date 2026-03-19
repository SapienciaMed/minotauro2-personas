class ErrorMailer < ApplicationMailer
	def datos(portafolio_id,user_id)
    @user_id = user_id
    @portafolio_id =  portafolio_id
    mail(to: 'dhernandez@sygma-tech.co, ffernandez@sygma-tech.co, apelaez@sygma-tech.co', subject: 'Error 500 - Teseo')
  end
end
