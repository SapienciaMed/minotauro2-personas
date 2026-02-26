class Notifier < ActionMailer::Base
=begin
  def bdme_message(recipient)
    subject      'Fondo Medellín EPM - G-Intac'
    recipients   recipient.email
    reply_to     recipient.email
    from         'correo@g_intac.gov.co'
    body         :objeto=> recipient
    content_type "text/html"
  end

  def notificacion_message(recipient)
    subject      'Notificación G-Intac'
    recipients   recipient.email
    reply_to     recipient.email
    bcc          'fabian.mosquera@g_intac.gov.co'
    from         'correo@g_intac.gov.co'
    body         :persona=> recipient
    content_type "text/html"
  end

  def notifiresolucion_message(recipient,recipient1,recipient2)
    subject      'Notificación Resolución G-Intac'
    recipients   recipient.email
    reply_to     recipient.email
    bcc          'fabian.mosquera@g_intac.gov.co'
    from         'correo@g_intac.gov.co'
    body         :persona=> recipient
    content_type "multipart/mixed"
    part 'text/html' do |p|
        p.body = render_message("notifiresolucion_message", { :persona => recipient })
    end
    attachment "application/pdf" do |a|
        a.content_disposition = "attachment"
        a.body = File.new("#{Rails.root}/public/system/personas/#{recipient1}/original/#{recipient2}",'rb').read()
        a.filename = "#{recipient2}"
    end
  end

  def amortizacion_message(recipient,recipient1,recipient2)
    subject      'G-Intac - CRÉDITO FONDO MEDELLÍN EPM'
    recipients   recipient.email
    reply_to     recipient.email
#    bcc          'fabian.mosquera@g_intac.gov.co'
    from         'correo@g_intac.gov.co'
    body         :persona=> recipient
    content_type "multipart/mixed"
    part 'text/html' do |p|
        p.body = render_message("amortizacion_message", { :persona => recipient })
    end
    attachment "application/pdf" do |a|
        a.content_disposition = "attachment"
        a.body = File.new("#{Rails.root}/public/system/personas/#{recipient1}/original/#{recipient2}",'rb').read()
        a.filename = "#{recipient2}"
    end
  end

  def amortizacion2_message(recipient,recipient1,recipient2)
    subject      'Beneficiarios Plan Amortización G-Intac'
    recipients   recipient.email
    reply_to     recipient.email
    bcc          'sahara.mancera@g_intac.gov.co'
    from         'correo@g_intac.gov.co'
    body         :persona=> recipient
    content_type "multipart/mixed"
    part 'text/html' do |p|
        p.body = render_message("amortizacion2_message", { :persona => recipient })
    end
    attachment "application/pdf" do |a|
        a.content_disposition = "attachment"
        a.body = File.new("#{Rails.root}/public/system/personas/#{recipient1}/original/#{recipient2}",'rb').read()
        a.filename = "#{recipient2}"
    end
  end

  def sendaprobacion_message(recipient,recipient1,recipient2)
    subject      'Comunicación Aprobación Ampliación Plazo - G-Intac'
    recipients   recipient.email
    reply_to     recipient.email
    bcc          'sahara.mancera@g_intac.gov.co'
    from         'correo@g_intac.gov.co'
    body         :persona=> recipient
    content_type "multipart/mixed"
    part 'text/html' do |p|
        p.body = render_message("sendaprobacion_message", { :persona => recipient })
    end
    attachment "application/pdf" do |a|
        a.content_disposition = "attachment"
        a.body = File.new("#{Rails.root}/public/system/personas/#{recipient1}/original/#{recipient2}",'rb').read()
        a.filename = "#{recipient2}"
    end
  end

  def et_message(recipient)
    subject      'Fondo Medellín EPM - Inicio etapa amortización crédito educativo- G-Intac'
    recipients   recipient.email
    reply_to     recipient.email
    from         'correo@g_intac.gov.co'
    body         :objeto=> recipient
    content_type "multipart/mixed"
    part 'text/html' do |p|
        p.body = render_message("et_message", { :objeto=> recipient })
    end
    attachment "application/pdf" do |a|
        a.content_disposition = "attachment"
        a.body = File.new("#{Rails.root}/public/resoluciones/Amortizacion_Ben_#{recipient.obligacion.to_s}.pdf",'rb').read()
        a.filename = "Amortizacion_Ben_#{recipient.obligacion.to_s}.pdf"
    end
  end
=end
end


