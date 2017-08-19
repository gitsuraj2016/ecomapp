class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :check_cart

  def check_cart
  	  @cart = Cart.find(session[:cart_id])
      @item_count = @cart.line_items.count
  end

  # def current_user
	 #  begin
	 #    @current_user ||= User.find(session[:user_id]) if session[:user_id]
	 #  rescue
	 #    session[:user_id] = nil
	 #  end
  # end
  # helper_method :current_user
end
