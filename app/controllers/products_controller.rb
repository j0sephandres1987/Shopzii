class ProductsController < ApplicationController
  layout 'admin'
  before_action :confirm_logged_in

  def index
    @products = Product.select_data(nil, nil, nil).paginate(:page => params[:page], :per_page => 5)
    @sort_by_options = [["Mas reciente", "created_at DESC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "DESC"? true : false], ["Mas antiguo", "created_at ASC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente A-Z", "name ASC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente Z-A", "name DESC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "DESC"? true : false]]
    @no_data = false
    if @products.empty?
      flash[:no_data] = "No hay productos"
      @no_data = true
    else
      flash[:no_data] = nil
      @no_data = false
    end
  end

  def new
    @shipment_methods = ShipmentMethod.all
    @product = Product.new
    @collections = Collection.all
    @categories = Category.all
    5.times { @product.photos.build }
  end

  def edit
    @product = Product.find(params[:id])
    cant = 5 - @product.photos.count
    #cant.times { @product.photos.build }
    @categories = Category.all
    @shipment_methods = ShipmentMethod.all
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(product_params)
      join_shipment_method_product(product_params[:shipment_method_ids], @product.id)
      flash[:notice] = "El producto se modifico exitosamente"
      cookies[:from_edit] = true
      redirect_to(:action => "index")
    else
      flash[:notice] = "El producto no se pudo modificar"
      redirect_to(:action => "index")
    end
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      join_shipment_method_product([product_params[:shipment_method_ids]], @product.id)
      redirect_to(:action => "index")
    end
  end

  def delete_all
    respond_to do |format|
      @products = Product.all
      if @products.destroy_all
        cookies[:search_query] = nil
        @success = "true"
        @message = "Todas los productos se eliminaron correctamente"
        @products = Product.all
        format.html { redirect_to(:action => "index") }
        format.js
      end
    end
  end

  def properties
    @property = Property.new(:product_id => params[:id])
    @properties = Property.where(:product_id => params[:id])
    @no_data = false
    if @properties.empty?
      flash[:no_data] = "No hay propiedades"
      @no_data = true
    else
      flash[:no_data] = nil
      @no_data = false
    end
  end

  def values
    @value = Value.new(:property_id => params[:id])
    @values = Value.where(:property_id => params[:id])
    @no_data = false
    if @values.empty?
      flash[:no_data] = "No hay valores"
      @no_data = true
    else
      flash[:no_data] = nil
      @no_data = false
    end
  end

  def create_value
    respond_to do |format|
      if Value.create(value_params)
        property_id = value_params[:property_id]
        @values = Value.where(:property_id => property_id)
        @success = "true"
        @message = "El valor se creo exitosamente"
        format.html { redirect_to(:action => "values", :id => property_id) }
        format.js
      else
        @success = "false"
        @message = "No se pudo crear el valor"
        format.html { redirect_to(:action => "values", :id => property_id) }
        format.js
      end
    end
  end

  def edit_value
    @value = Value.find(params[:id])
  end

  def update_value
    @value = Value.find(params[:id])
    property_id = @value.property_id
    if @value.update_attributes(value_params)
      flash[:notice] = "El valor se modifico exitosamente"
      redirect_to(:action => "values", :id => property_id)
    else
      flash[:notice] = "El valor no se pudo modificar"
      redirect_to(:action => "values", :id => property_id)
    end
  end

  def create_property
    respond_to do |format|
      if Property.create(property_params)
        product_id = property_params[:product_id]
        @properties = Property.where(:product_id => product_id)
        @success = "true"
        @message = "La propiedad se creo exitosamente"
        format.html { redirect_to(:action => "properties", :id => product_id) }
        format.js
      else
        @success = "false"
        @message = "No se pudo crear la propiedad"
        format.html { redirect_to(:action => "properties", :id => product_id) }
        format.js
      end
    end
  end

  def edit_property
    @property = Property.find(params[:id])
  end

  def update_property
    @property = Property.find(params[:id])
    if @property.update_attributes(property_params)
      flash[:notice] = "La propiedad se modifico exitosamente"
      redirect_to(:action => "properties", :id => @property.product_id)
    else
      flash[:notice] = "La propiedad no se pudo modificar"
      redirect_to(:action => "show", :id => @property.product_id)
    end
  end

  def delete_property
    @property = Property.find(params[:id])
    product_id = @property.product_id
    respond_to do |format|
      if @property.destroy
        @properties = Property.where(:product_id => product_id)
        @success = "true"
        @message = "La propiedad se elimino exitosamente"
        format.html { redirect_to(:action => "properties", :id => product_id) }
        format.js
      else
        @success = "false"
        @message = "No se pudo eliminar la propiedad"
        format.html { redirect_to(:action => "properties", :id => product_id) }
        format.js
      end
    end
  end

  def delete_value
    @value = Value.find(params[:id])
    property_id = @value.property_id
    respond_to do |format|
      if @value.destroy
        @values = Value.where(:property_id => property_id)
        @success = "true"
        @message = "El valor se elimino exitosamente"
        format.html { redirect_to(:action => "values", :id => property_id) }
        format.js
      else
        @success = "false"
        @message = "No se pudo eliminar el valor"
        format.html { redirect_to(:action => "values", :id => property_id) }
        format.js
      end
    end
  end

  def join_shipment_method_product(selected, product_id)
    selected.pop
    product = Product.find(product_id)
    shipment_method = ShipmentMethod.find(selected)
    product.shipment_methods << shipment_method
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category_id, :subcategory_id, :shipment_method_ids => [], photos_attributes: [:photo])
  end

  def property_params
    params.require(:property).permit(:name, :product_id)
  end

  def value_params
    params.require(:value).permit(:name, :property_id)
  end
end
