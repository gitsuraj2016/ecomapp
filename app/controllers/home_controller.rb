class HomeController < ApplicationController
  def index
  	  @abc = 1
      @categories = Category.order("id asc").all
      @subcategories = Subcategory.order("id asc").all
      @products = Product.all
      @cat_products = @subcategories.first.products
      # @cat_products.each do | xx |
      #   puts xx.name
      # end
      # puts "#{@cat_products.inspect}"
      if session[:cart_id].present?
        @cart = Cart.find(session[:cart_id])
        @item_count = @cart.line_items.count
     end
  end

  def product_list

      cat_id  = params[:cat_id]
      # @categories = Category.order("id asc").all
      @category = Category.where(:id=>cat_id).first
      @subcategories = @category.subcategories
      puts ">>>>>>>>>>sub cat>>>>>>>>>>#{@subcategories.inspect}"

      @products = Product.all
      @subcat_products = @subcategories.first.products
      puts ">>>>>>>>>sub pro>>>>>>>>>#{@subcat_products.inspect}"
  	
  end

  def product_update
     
      Product.update_all(:subcategory_id => 1)
      render :json => {:success => 'success'}.to_json
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
