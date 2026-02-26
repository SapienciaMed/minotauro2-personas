# Preview all emails at http://localhost:3000/rails/mailers/personasacuerdo_mailer
class PersonasacuerdoMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/personasacuerdo_mailer/user
  def user
    PersonasacuerdoMailer.user
  end

  # Preview this email at http://localhost:3000/rails/mailers/personasacuerdo_mailer/personasacuerdo
  def personasacuerdo
    PersonasacuerdoMailer.personasacuerdo
  end

end
