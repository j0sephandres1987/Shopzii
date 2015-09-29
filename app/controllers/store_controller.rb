class StoreController < ApplicationController
  layout 'store'
  def index
    #session[:items_quantity] = 0
    #session[:total_value] = 0
    #session[:cart] = nil
    #session[:order_id] = nil
    @categories = Category.all
    @products = Product.select_data(nil, nil, nil).paginate(:page => params[:page], :per_page => 12)
  end

  def show_by_category
    @categories = Category.all
    @products = Product.select_data(nil, nil, nil).filter(:category_id, params[:id]).paginate(:page => params[:page], :per_page => 12)
  end

  def show_product
    @categories = Category.all
    @product = Product.find(params[:id])
    @cart_item = CartItem.new(:product_id => params[:id])
    if session[:items_quantity].nil?
      session[:items_quantity] = 0
    end
    if session[:total_value].nil?
      session[:total_value] = 0
    end
  end

  def get_properties_names(product)
    names = Array.new
    product.properties.each do |p|
      names << p.name.downcase + "_id"
    end
    return names
  end

  def add_to_cart
    order = current_order
    product = Product.find(params[:product_id])
    @cart_item = CartItem.create(:product => product, :order => order, :quantity => cart_item_params[:quantity])
    properties_names = get_properties_names(product)
    properties_names.each do |pn|
      join_value_cart_item(params["#{pn}"], @cart_item.id)
    end
    if @cart_item
      session[:items_quantity] += 1
      session[:total_value] += product.price * @cart_item.quantity
      @items_quantity = session[:items_quantity]
      @total_value = session[:total_value]
      respond_to do |format|
        format.html { redirect_to(:action => "show_product", :id => product.id) }
        format.js
      end
    end
  end

  def show_cart
    @cart_items = CartItem.where(:order_id => session[:order_id])
    @preference = Store.new.mercado_pago_checkout
  end

  def join_value_cart_item(value_id, cart_item_id)
    cart_item = CartItem.find(cart_item_id)
    value = Value.find(value_id)
    cart_item.values << value
  end

  def current_order
    @order = Order.find(session[:order_id])
    return @order
  rescue ActiveRecord::RecordNotFound
    @order = Order.create
    session[:order_id] = @order.id
    return @order
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end

end
