class Planesfactura < ApplicationRecord
  belongs_to :personasobligacion

  def periodo
    "<b>Periodo:</b> #{self.created_at.strftime('%m')}_#{self.created_at.strftime('%Y')}".html_safe
  end
end
