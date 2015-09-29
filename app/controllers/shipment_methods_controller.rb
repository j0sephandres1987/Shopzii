class ShipmentMethodsController < ApplicationController
  layout "admin"
  before_action :confirm_logged_in

  def index
    @shipment_method = ShipmentMethod.new
    @shipment_methods = ShipmentMethod.select_data(nil, nil, nil).paginate(:page => params[:page], :per_page => 5)
    @sort_by_options = [["Mas reciente", "created_at DESC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "DESC"? true : false], ["Mas antiguo", "created_at ASC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente A-Z", "name ASC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente Z-A", "name DESC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "DESC"? true : false]]
    @no_data = false
    if @shipment_methods.empty?
      flash[:no_data] = "No hay medios de envios."
      @no_data = true
    else
      flash[:no_data] = nil
      @no_data = false
    end
  end

  def show
    cookies[:search_query] = nil
    cookies[:from_edit].nil?
    @sort_by_options = [["Mas reciente", "created_at DESC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "DESC"? true : false], ["Mas antiguo", "created_at ASC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente A-Z", "name ASC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente Z-A", "name DESC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "DESC"? true : false]]
    @shipment_method = ShipmentMethod.find(params[:id])
    @no_data = false
  end

  def create
    cookies[:search_query] = nil
    cookies[:from_edit] = nil
    respond_to do |format|
      if ShipmentMethod.create(shipment_method_params)
        @shipment_methods = ShipmentMethod.sorted_by_date_desc.paginate(:page => params[:page], :per_page => 5)
        @success = "true"
        @message = "El medio de envio se creo exitosamente"
        format.html { redirect_to(:action => "index") }
        format.js
      else
        @success = "false"
        @message = "No se pudo crear el medio de envio"
        format.html { redirect_to(:action => "index") }
        format.js
      end
    end
  end

  def edit
    @shipment_method = ShipmentMethod.find(params[:id])
  end

  def update
    @shipment_method = ShipmentMethod.find(params[:id])
    if @shipment_method.update_attributes(shipment_method_params)
      flash[:notice] = "El medio de envio se modifico exitosamente"
      cookies[:from_edit] = true
      redirect_to(:action => "index")
    else
      flash[:notice] = "El medio de envio no se pudo modificar"
      redirect_to(:action => "index")
    end
  end

  def delete
    @shipment_method = ShipmentMethod.find(params[:id])
    respond_to do |format|
      if @shipment_method.destroy
        @shipment_methods = ShipmentMethod.select_data(cookies[:search_query], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
        @success = "true"
        @message = "El medio de envio se elimino exitosamente"
        format.html { redirect_to(:action => "index") }
        format.js
      else
        @success = "false"
        @message = "No se pudo eliminar el medio de envio"
        format.html { redirect_to(:action => "index") }
        format.js
      end
    end
  end

  def delete_all
    respond_to do |format|
      @shipment_methods = ShipmentMethod.all
      if @shipment_methods.destroy_all
        cookies[:search_query] = nil
        @success = "true"
        @message = "Todas los medios de envio se eliminaron correctamente"
        @shipment_method = ShipmentMethod.all
        format.html { redirect_to(:action => "index") }
        format.js
      end
    end
  end

  def delete_selected
    @count = 0
    respond_to do |format|
      @selected = ShipmentMethod.find(params[:selected])
      @selected.each do |s|
        if !s.destroy
          @count = @count + 1
        end
      end
      @shipment_methods = ShipmentMethod.select_data(cookies[:search_query], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
      @count > 0 ? @success = "false" : @success = "true"
      @success == "true" ? @message = "Los medios de envio seleccionados, se eliminaron correctamente" : @message = "Los medios de envio seleccionados, no pudieron eliminarse"
      format.html { redirect_to(:action => "index") }
      format.js
    end
  end

  def search
    respond_to do |format|
      @shipment_methods = ShipmentMethod.select_data(params[:search_text], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
      @shipment_methods.count != 1 ? found = " medios de envio encontrados." : found = " medio de envio encontrado."
      @message = @shipment_methods.count.to_s + found
      unless @shipment_methods.empty?
        cookies[:search_query] = params[:search_text]
        @success = "true"
        format.html { redirect_to(:action => "index") }
        format.js
      else
        cookies[:search_query] = nil
        @success = "false"
        format.html { redirect_to(:action => "index") }
        format.js
      end
    end
  end

  def sort
    respond_to do |format|
      sort_by_attr = params[:sort_by_option].to_s.split(" ")[0]
      sort_order = params[:sort_by_option].to_s.split(" ")[1]
      cookies[:sort_by_attr] = sort_by_attr
      cookies[:sort_order] = sort_order
      @shipment_methods = ShipmentMethod.select_data(cookies[:search_query], sort_by_attr, sort_order).paginate(:page => params[:page], :per_page => 5)
      format.html { redirect_to(:action => "index") }
      format.js
    end
  end

  private

  def shipment_method_params
    params.require(:shipment_method).permit(:name, :delivery_time, :price)
  end
end
