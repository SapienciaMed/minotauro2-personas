module ViewRegister
  extend ActiveSupport::Concern

  def descripcion_registro
    <<~HTML
      Fecha creacion: #{self.created_at.strftime("%Y-%m-%d %X")} - 
      Usuario: #{self.user.username}
    HTML
  end
end
