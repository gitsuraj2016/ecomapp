class HomeController < ApplicationController
  def index
  	  @abc = 1
      @categories = Category.order("id asc").all
      @products = Product.all
      @cat_products = @categories.first.products
      # @cat_products.each do | xx |
      #   puts xx.name
      # end
      # puts "#{@cat_products.inspect}"
      @cart = Cart.find(session[:cart_id])
      @item_count = @cart.line_items.count
  end

  def product_list
      @categories = Category.order("id asc").all
      @products = Product.all
      @cat_products = @categories.first.products
  	
  end

  def product_detail

  end

  def my_order

  end

  def check_out

  end

  def my_cart
  end

end
