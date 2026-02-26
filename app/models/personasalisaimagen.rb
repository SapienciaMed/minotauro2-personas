class Personasalisaimagen < ActiveRecord::Base
  belongs_to :personasalisasociado
  belongs_to :user

  has_attached_file :peralisasociado, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :peralisasociado
  validates_attachment_presence :peralisasociado, :message => 'Debe seleccionar un archivo valido!!'

end
