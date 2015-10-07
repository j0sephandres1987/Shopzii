class OrdersController < ApplicationController
  layout "admin"
    def index
        #@paids = Order.new.mercado_pago_payment_notification(params[:id])
        @orders = Order.sorted_by_date_desc.paginate(:page => params[:page], :per_page => 5)
        @sort_by_options = [["Mas reciente", "created_at DESC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "DESC"? true : false], ["Mas antiguo", "created_at ASC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente A-Z", "name ASC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente Z-A", "name DESC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "DESC"? true : false]]
        @no_data = false
        if @orders.empty?
          flash[:no_data] = "No hay pedidos"
          @no_data = true
        else
          flash[:no_data] = nil
          @no_data = false
        end
    end
    
    def show
      @section = "admin"
      @order = Order.find(params[:id])
      @cart_items = Order.find(params[:id]).cart_items
    end
    
end
