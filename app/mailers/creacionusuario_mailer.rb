class CreacionusuarioMailer < ApplicationMailer
  def envio_correo(user)
    @user = User.find(user.id)
    mail(to: @user.email, subject: 'Bienvenido(a) a la plataforma SAPIENCIA', bcc: 'apelaez@sygma-tech.co')
  end
end