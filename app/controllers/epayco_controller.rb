class EpaycoController < ApplicationController
  layout :set_layout

  def links
    @personasoblrecibos = Personasoblrecibo.where("forma_pago = 'COBRA'").order("id desc")
    @personasoblrecibo = Personasoblrecibo.new
  end

  private
  def set_layout
    if ['links'].include?(action_name)#ojo prueb
      "application_admin"
    else
      "application_admin"
    end
  end
end
