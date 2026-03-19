class Archivo < ApplicationRecord
  belongs_to :user

  has_attached_file :upload

  validates_presence_of :upload
  validates_attachment_content_type :upload, content_type: /\A*\/.*\Z/

  after_save :validarruta

  def namefile
    n = File.basename(self.upload_file_name, ".xlsx")
    return n
  end

  private

  def validarruta
    name = self.upload_file_name
    ruta = "#{::Rails.root}/public/system/uploades/#{self.id}/original/#{name}"
    siexiste = self.upload_file_name.present? && File.exist?(ruta)

    update_column(:validacionruta, siexiste)
  end
end
