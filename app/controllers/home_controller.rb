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
      @products = Product.all
      @subcat_products_list = @subcategories.first.products
      @subcat_products  = @subcat_products_list.paginate(page: params[:page], per_page: 2)
  	
  end

  # def product_update
     
  #     Product.update_all(:subcategory_id => 1)
  #     render :json => {:success => 'success'}.to_json
  # end

  def product_detail

  end
  def product_search

       if params[:search].present?
         @ser_text = params[:search]
         @subcat_products = Product.where("name like '%#{params[:search].strip}%' or description like '%#{params[:search].strip}%'").paginate(page: params[:page], per_page: 2)
         @pro_count = @subcat_products.count 
         @filter_cats = Category.order("id asc").all
         @filter_brand = Product.all
         @filter_color = Subcategory.order("id asc").all
         @filter_sort = Product.all
         @filter_price = Subcategory.order("id asc").all
       else
         @subcat_products = Product.all.paginate(page: params[:page], per_page: 2)
       end

  end

  def checkbox_filter
    # @products = Product.joins(:categories).where(categories: { id: params[:cat_id] })
    # respond_to do |format|
    #   format.js
    # end


  end

  def filter_listing
      puts "filter_checkbox called"
       params[:filter_checkbox].each do |key, value|
        puts "#{key} ........ #{value}"
       end
      # @query=""
    # if params[:filter_checkbox].present?
    #   params[:filter_checkbox].each do |key, value|
    #     if key=="price" and value!=""
    #       c_id=Amount.where("#{key} <= #{value}").pluck('distinct product_spec_id').join(', ')
    #       puts c_id
    #       puts "price_id"
    #       if c_id!=""
    #         @query+=" and id in(0#{c_id})"
    #       end
    #     elsif key=="color_id" and value!=""
    #       c_id=ProductSpecColor.where("#{key} in(#{value})").pluck('distinct product_spec_id').join(', ')
    #       if c_id!=""
    #         @query+=" and is_color=1 and id in(#{c_id})"
    #       end
    #     elsif key=="cycle_id" and value!=""
    #       @query+=" and deleted = 0 and #{key} in(#{value})"
    #     elsif key=="is_color" and value!=""
    #       @query+=" and is_color=1"
    #     elsif key=="is_toric" and value!=""
    #       @query+=" and is_toric=1"
    #     elsif value!=""
    #       @query+=" and #{key} in(#{value})"
    #     end
    #   end
    #   if params[:search].present?
    #     @query+=" and (name like '%#{params[:search].strip}%' or description like '%#{params[:search].strip}%')"
    #   end
    #   @productspecs = ProductSpec.where("product_type_id=#{product_type_id} #{@query}").order("name").paginate :page=>params[:page], :per_page => 18
    # end
    render :json => {:success => 'Error'}.to_json
  end

  

end
