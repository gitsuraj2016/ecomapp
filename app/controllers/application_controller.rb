class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_cart, :check_user


  def check_user
      @user_id = nil
      if current_user.present?
          @user = User.find_by(id: current_user.id)
          @user_id = @user.id
      end
  end

  def check_cart
      @item_count = 0
     if session[:cart_id].present?
        @cart = Cart.find(session[:cart_id])
        @item_count = @cart.line_items.count
     end
  	  
  end

  def current_user
	  begin
	    @current_user ||= User.find(session[:user_id]) if session[:user_id]
	  rescue
	    session[:user_id] = nil
	  end
  end
  helper_method :current_user
end
