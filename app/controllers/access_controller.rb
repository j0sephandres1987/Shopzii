class AccessController < ApplicationController
  layout 'admin_access'

  def login
    @user = User.new
  end

  def attempt_login
    if login_params[:username].present? && login_params[:password].present?
      found_user = User.find_by_username(login_params[:username])
    end
    if found_user
      authorized_user = found_user.authenticate(login_params[:password])
    end
    if authorized_user
      session[:user_id] = authorized_user.id
      #session[:store_id] = Store.where(user_id => authorized_user.id).id
      #session[:store_name] = Store.where(user_id => authorized_user.id).name
      session[:username] = authorized_user.username
      @success = "true"
      redirect_to(:controller => "products", :action => "index")
    else
      session[:user_id] = nil
      session[:username] = nil
      session[:store_id] = nil
      session[:store_name] = nil
      flash[:error] = "Usuario y/o contrasena incorrectas."
      render (:login)
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    redirect_to(:action => "login")
  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end
end
