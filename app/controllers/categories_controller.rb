class CategoriesController < ApplicationController
  layout 'admin'
  before_action :confirm_logged_in
  def index
    cookies[:search_subcategory_query] = nil
    @sort_by_options = [["Mas reciente", "created_at DESC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "DESC"? true : false], ["Mas antiguo", "created_at ASC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente A-Z", "name ASC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente Z-A", "name DESC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "DESC"? true : false]]
    if !cookies[:from_edit].nil?
      cookies[:from_edit] = nil
      sort_attr = "updated_at"
      sort_order = "DESC"
      cookies[:search_query] = nil
      query = nil
    else
      sort_attr = cookies[:sort_by_attr]
      sort_order = cookies[:sort_order]
      #query = cookies[:search_query]
      query = nil
    end
    @categories = Category.select_data(query, sort_attr, sort_order).paginate(:page => params[:page], :per_page => 5)
    @category = Category.new
    @no_data = false
    if @categories.empty?
      flash[:no_data] = "No hay categorias"
      @no_data = true
    else
      flash[:no_data] = nil
      @no_data = false
    end
  end

  def create
    cookies[:search_query] = nil
    cookies[:from_edit] = nil
    respond_to do |format|
      if Category.create(category_params)
        @categories = Category.sorted_by_date_desc.paginate(:page => params[:page], :per_page => 5)
        @success = "true"
        @message = "La categoria se creo exitosamente"
        format.html { redirect_to(:action => "index") }
        format.js
      else
        @success = "false"
        @message = "No se pudo crear la categoria"
        format.html { redirect_to(:action => "index") }
        format.js
      end
    end
  end

  def create_subcategory
    cookies[:search_query] = nil
    cookies[:search_subcategory_query] = nil
    @category_id = subcategory_params[:category_id]
    respond_to do |format|
      if Subcategory.create(subcategory_params)
        @subcategories = Category.find(subcategory_params[:category_id]).subcategories.select_data(nil, nil, nil).paginate(:page => params[:page], :per_page => 5)
        @success = "true"
        @message = "La subcategoria se creo exitosamente"
        format.html { redirect_to(:action => "show") }
        format.js
      else
        @success = "false"
        @message = "No se pudo crear la subcategoria"
        format.html { redirect_to(:action => "show") }
        format.js
      end
    end
  end

  def show
    cookies[:search_query] = nil
    cookies[:search_subcategory_query] = nil
    if !cookies[:from_edit].nil?
      cookies[:from_edit] = nil
      sort_attr = "updated_at"
      sort_order = "DESC"
      cookies[:search_query] = nil
      query = nil
    else
      sort_attr = cookies[:sort_by_attr]
      sort_order = cookies[:sort_order]
      #query = cookies[:search_query]
      query = nil
    end
    #si viene de index o reload properties search_query debe ser nil
    @sort_by_options = [["Mas reciente", "created_at DESC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "DESC"? true : false], ["Mas antiguo", "created_at ASC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente A-Z", "name ASC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente Z-A", "name DESC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "DESC"? true : false]]
    @collection = Collection.find(params[:id])
    @categories = Collection.find(params[:id]).categories.select_data(query, sort_attr, sort_order).paginate(:page => params[:page], :per_page => 5)
    @category = Category.new(:collection_id => params[:id])
    @no_data = false
    if @categories.empty?
      flash[:no_data] = "No hay categories"
      @no_data = true
    else
      flash[:no_data] = nil
      @no_data = false
    end
  end

  def show_subcategories
    cookies[:search_query] = nil
    cookies[:search_subcategory_query] = nil
    if !cookies[:from_edit].nil?
      cookies[:from_edit] = nil
      sort_attr = "updated_at"
      sort_order = "DESC"
      cookies[:search_query] = nil
      query = nil
    else
      sort_attr = cookies[:sort_by_attr]
      sort_order = cookies[:sort_order]
      #query = cookies[:search_query]
      query = nil
    end
    #si viene de index o reload properties search_query debe ser nil
    @sort_by_options = [["Mas reciente", "created_at DESC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "DESC"? true : false], ["Mas antiguo", "created_at ASC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente A-Z", "name ASC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente Z-A", "name DESC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "DESC"? true : false]]
    @category = Category.find(params[:id])
    @subcategories = Category.find(params[:id]).subcategories.select_data(query, sort_attr, sort_order).paginate(:page => params[:page], :per_page => 5)
    @subcategory = Subcategory.new(:category_id => params[:id])
    @no_data = false
    if @subcategories.empty?
      flash[:no_data] = "No hay subcategories"
      @no_data = true
    else
      flash[:no_data] = nil
      @no_data = false
    end
  end

  def show_subcategory
    cookies[:search_query] = nil
    cookies[:search_subcategory_query] = nil
    cookies[:from_edit].nil?
    @sort_by_options = [["Mas reciente", "created_at DESC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "DESC"? true : false], ["Mas antiguo", "created_at ASC", :selected => cookies[:sort_by_attr] == "created_at" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente A-Z", "name ASC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "ASC"? true : false], ["Alfabeticamente Z-A", "name DESC", :selected => cookies[:sort_by_attr] == "name" && cookies[:sort_order] == "DESC"? true : false]]
    @subcategories = Subcategory.find(params[:id])
    @category = Category.find(@subcategories.category_id)
    @subcategory = Subcategory.new(:category_id => @subcategories.category_id)
    @no_data = false

  end

  def edit
    @collection = Collection.find(params[:id])
  end

  def edit_category
    @category = Category.find(params[:id])
  end

  def edit_subcategory
    @subcategory = Subcategory.find(params[:id])
  end

  def update
    @collection = Collection.find(params[:id])
    if @collection.update_attributes(collection_params)
      flash[:notice] = "La coleccion se modifico exitosamente"
      cookies[:from_edit] = true
      redirect_to(:action => "index")
    else
      flash[:notice] = "La coleccion no se pudo modificar"
      redirect_to(:action => "index")
    end
  end

  def update_category
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      flash[:notice] = "La categoria se modifico exitosamente"
      cookies[:from_edit] = true
      redirect_to(:action => "show", :id => @category.collection_id)
    else
      flash[:notice] = "La categoria no se pudo modificar"
      redirect_to(:action => "show", :id => @category.collection_id)
    end
  end

  def update_subcategory
    @subcategory = Subcategory.find(params[:id])
    if @subcategory.update_attributes(subcategory_params)
      flash[:notice] = "La subcategoria se modifico exitosamente"
      cookies[:from_edit] = true
      redirect_to(:action => "show_subcategories", :id => @subcategory.category_id)
    else
      flash[:notice] = "La subcategoria no se pudo modificar"
      redirect_to(:action => "show_subcategories", :id => @subcategory.category_id)
    end
  end

  def delete
    @collection = Collection.find(params[:id])
    respond_to do |format|
      if @collection.destroy
        @collections = Collection.select_data(cookies[:search_query], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
        @success = "true"
        @message = "La coleccion se elimino exitosamente"
        format.html { redirect_to(:action => "index") }
        format.js
      else
        @success = "false"
        @message = "No se pudo eliminar la coleccion"
        format.html { redirect_to(:action => "index") }
        format.js
      end
    end
  end

  def delete_category
    @category = Category.find(params[:id])
    @collection_id = @category.collection_id
    respond_to do |format|
      if @category.destroy
        @categories = Collection.find(@collection_id).categories.select_data(cookies[:search_category_query], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
        @success = "true"
        @message = "La categoria se elimino exitosamente"
        format.html { redirect_to(:action => "show") }
        format.js
      else
        @success = "false"
        @message = "No se pudo eliminar la categoria"
        format.html { redirect_to(:action => "show") }
        format.js
      end
    end
  end

  def delete_subcategory
    @subcategory = Subcategory.find(params[:id])
    @category_id = @subcategory.category_id
    respond_to do |format|
      if @subcategory.destroy
        @subcategories = Category.find(@category_id).subcategories.select_data(cookies[:search_subcategory_query], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
        @success = "true"
        @message = "La subcategoria se elimino exitosamente"
        format.html { redirect_to(:action => "show_subcategories", :id => @category_id) }
        format.js
      else
        @success = "false"
        @message = "No se pudo eliminar la subcategoria"
        format.html { redirect_to(:action => "show_subcategories", :id => @category_id) }
        format.js
      end
    end
  end

  def delete_selected
    @count = 0
    respond_to do |format|
      @selected = Collection.find(params[:selected])
      @selected.each do |s|
        if !s.destroy
          @count = @count + 1
        end
      end
      @collections = Collection.select_data(cookies[:search_query], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
      @count > 0 ? @success = "false" : @success = "true"
      @success == "true" ? @message = "Las colecciones seleccionadas, se eliminaron correctamente" : @message = "Las colecciones seleccionadas, no pudieron eliminarse"
      format.html { redirect_to(:action => "index") }
      format.js
    end
  end

  def delete_selected_categories
    @count = 0
    respond_to do |format|
      @selected = Category.find(params[:selected])
      @collection_id = @selected.first.collection_id
      @selected.each do |s|
        if !s.destroy
          @count = @count + 1
        end
      end
      @categories = Collection.find(@collection_id).categories.select_data(cookies[:search_category_query], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
      @count > 0 ? @success = "false" : @success = "true"
      @success == "true" ? @message = "Las categorias seleccionadas, se eliminaron correctamente" : @message = "Las categorias seleccionadas, no pudieron eliminarse"
      format.html { redirect_to(:action => "show") }
      format.js
    end
  end

  def delete_selected_subcategories
    @count = 0
    respond_to do |format|
      @selected = Subcategory.find(params[:selected])
      @category_id = @selected.first.category_id
      @selected.each do |s|
        if !s.destroy
          @count = @count + 1
        end
      end
      @subcategories = Category.find(@category_id).subcategories.select_data(cookies[:search_subcategory_query], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
      @count > 0 ? @success = "false" : @success = "true"
      @success == "true" ? @message = "Las subcategorias seleccionadas, se eliminaron correctamente" : @message = "Las subcategorias seleccionadas, no pudieron eliminarse"
      format.html { redirect_to(:action => "show_subcategories") }
      format.js
    end
  end

  def delete_all
    respond_to do |format|
      @collections = Collection.all
      if @collections.destroy_all
        cookies[:search_category_query]
        @success = "true"
        @message = "Todas las colecciones seleccionadas, se eliminaron correctamente"
        @collection = Collection.all
        format.html { redirect_to(:action => "index") }
        format.js
      end
    end
  end

  def delete_all_categories
    respond_to do |format|
      @categories = Collection.find(params[:id]).categories
      if @categories.destroy_all
        cookies[:search_category_query] = nil
        @success = "true"
        @message = "Todas las categorias seleccionadas, se eliminaron correctamente"
        @categories = Category.all
        format.html { redirect_to(:action => "show") }
        format.js
      end
    end
  end

  def delete_all_subcategories
    respond_to do |format|
      @subcategories = Category.find(params[:id]).subcategories
      if @subcategories.destroy_all
        cookies[:search_subcategory_query] = nil
        @success = "true"
        @message = "Todas las subcategorias seleccionadas, se eliminaron correctamente"
        @subcategories = Subcategory.all
        format.html { redirect_to(:action => "show_subcategories") }
        format.js
      end
    end
  end

  def search
    respond_to do |format|
      @collections = Collection.select_data(params[:search_text], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
      @collections.count != 1 ? found = " colecciones encontradas." : found = " coleccion encontrada."
      @message = @collections.count.to_s + found
      unless @collections.empty?
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

  def search_category
    respond_to do |format|
      @collection_id = params[:collection_id]
      cookies[:search_category_query] = params[:search_text]
      @categories = Collection.find(@collection_id).categories.select_data(cookies[:search_category_query], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
      @categories.count != 1 ? found = " categorias encontradas." : found = " categoria encontrada."
      @message = @categories.count.to_s + found
      unless @categories.empty?
        @success = "true"
        format.html { redirect_to(:action => "show") }
        format.js
      else
        cookies[:search_category_query] = nil
        @success = "false"
        format.html { redirect_to(:action => "show") }
        format.js
      end
    end
  end

  def search_subcategory
    respond_to do |format|
      @category_id = params[:category_id]
      cookies[:search_subcategory_query] = params[:search_text]
      @subcategories = Category.find(@category_id).subcategories.select_data(cookies[:search_subcategory_query], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
      @subcategories.count != 1 ? found = " subcategorias encontradas." : found = " subcategoria encontrada."
      @message = @subcategories.count.to_s + found
      unless @subcategories.empty?
        @success = "true"
        format.html { redirect_to(:action => "show_subcategories") }
        format.js
      else
        cookies[:search_subcategory_query] = nil
        @success = "false"
        format.html { redirect_to(:action => "show_subcategories") }
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
      @collections = Collection.select_data(cookies[:search_query], sort_by_attr, sort_order).paginate(:page => params[:page], :per_page => 5)
      format.html { redirect_to(:action => "index") }
      format.js
    end
  end

  def sort_categories
    respond_to do |format|
      @collection_id = params[:collection_id]
      sort_by_attr = params[:sort_by_option].to_s.split(" ")[0]
      sort_order = params[:sort_by_option].to_s.split(" ")[1]
      cookies[:sort_by_attr_category] = sort_by_attr
      cookies[:sort_order_category] = sort_order
      @categories = Collection.find(@collection_id).categories.select_data(cookies[:search_subcategory_query], cookies[:sort_by_attr_category], cookies[:sort_order_category]).paginate(:page => params[:page], :per_page => 5)
      format.html { redirect_to(:action => "show") }
      format.js
    end
  end

  def sort_subcategories
    respond_to do |format|
      @category_id = params[:category_id]
      sort_by_attr = params[:sort_by_option].to_s.split(" ")[0]
      sort_order = params[:sort_by_option].to_s.split(" ")[1]
      cookies[:sort_by_attr] = sort_by_attr
      cookies[:sort_order] = sort_order
      @subcategories = Category.find(@category_id).subcategories.select_data(cookies[:search_subcategory_query], cookies[:sort_by_attr], cookies[:sort_order]).paginate(:page => params[:page], :per_page => 5)
      format.html { redirect_to(:action => "show_subcategories") }
      format.js
    end
  end

  private

  def collection_params
    params.require(:collection).permit(:name)
  end

  def category_params
    params.require(:category).permit(:name, :collection_id)
  end

  def subcategory_params
    params.require(:subcategory).permit(:name, :category_id)
  end
end
