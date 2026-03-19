Recaptcha.configure do |config|
  config.site_key  = ENV['SITE_KEY'].to_s
  config.secret_key = ENV['SECRET_KEY'].to_s
  #config.site_key = '6LebSdgZAAAAAEsVF2bg9CLXiVVIkGNdBcltnmDS'
  #config.secret_key = '6LebSdgZAAAAAE_2C2pTJQ3oo9M_kFWgMxzjCOUp'
  #config.site_key  = '6LcaGNEZAAAAADC8OA3TFlte4qCrYaprpVvFwebx'
  #config.secret_key = '6LcaGNEZAAAAABOcl63FHhTLOU4f8L_CFintCrDC'
end