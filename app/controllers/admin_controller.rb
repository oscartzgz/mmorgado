class AdminController < ApplicationController
  def index
  end

  def import
    if params[:type] == 'providers'
      @import_data = ImportData.new(params[:file], Provider)
    elsif params[:type] == 'clients'
      @import_data = ImportData.new(params[:file], Client)
    elsif params[:type] == 'products'
      @import_data = ImportData.new(params[:file], Product)
    end

    if @import_data.save
      flash[:notice] = 'La información se importó con éxito.'
    else
      flash[:alert] = 'La información no se pudo importar correctamente.'
    end
    
    render :index
  end

end
