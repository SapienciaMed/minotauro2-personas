class DesembolsosController < ApplicationController
  before_filter :require_user
  require 'ruby_plsql'
  layout :determine_layout

  def visualizar
    @desembolso = Desembolso.find(params[:id])
  end


  private
  def determine_layout
    if ['visualizar'].include?(action_name)
      "basico"
    else
      "application"
    end
  end
end
