class TwoFactorController < ApplicationController
  prepend_before_action :check_captcha, only: [:recaptcha_session]

  layout :set_layout
  def activate
    current_user.unconfirmed_otp_secret = User.generate_otp_secret
    current_user.save!
    @qr_code = RQRCode::QRCode.new(two_factor_url).to_img.resize(240, 240).to_data_url
    current_user.activate_otp
    render :qr
  end

  def final
    render :otp    
  end

  def deactivate
    current_user.deactivate_otp
    redirect_back(fallback_location: root_path)
  end

  def two_factor_url
    app_id = "usuario"
    app_name = "Teseo"
    "otpauth://totp/#{app_id}:#{current_user.username}?secret=#{current_user.unconfirmed_otp_secret}&issuer=#{app_name}"
  end


  def recaptcha
  end

  def recaptcha_session
  end


  private

  # Descripcion: Verificacion de recaptcha
  def check_captcha
    unless !verify_recaptcha
      current_user.recaptcha_access = true
      current_user.save(validate: false)
      redirect_to root_path
    else
      redirect_to recaptcha_two_factor_index_path
    end
  end

  def set_layout
    if ['activate'].include?(action_name)
      'login'
    elsif ['recaptcha'].include?(action_name)
      'login_recaptcha'
    end
  end
end