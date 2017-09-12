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

  def delete_sub
     ProductColor.delete_all
     ProductBrand.delete_all
     Color.delete_all
     Brand.delete_all
     LineItem.delete_all
     Product.delete_all
     Subcategory.delete_all
     render :json => {:success => 'Error'}.to_json
  end

  def product_list

      cat_id  = params[:cat_id]
      # @categories = Category.order("id asc").all
      @category = Category.where(:id=>cat_id).first
      @subcategories = @category.subcategories
      # @products = Product.all
      @subcat_products_list = @subcategories.first.products
      @subcat_id_hidden = @subcategories.first.products.first.subcategory_id
      @subcat_products  = @subcat_products_list.paginate(page: params[:page], per_page: 10)

      @filter_cats = Subcategory.order("id asc").all
      @filter_brand = Brand.order("id asc").limit(6)
      @filter_color = Color.order("id asc").limit(6)
      @filter_sort = [
                  {"id" =>1,"name" =>"Popular item"},
                  {"id" =>2,"name" =>"Price: Low - High"},
                  {"id" =>3,"name" =>"Price: High - Low"},
                  {"id" =>4,"name" =>"Latest item"}]
      @filter_price = [
                  {"id" =>1,"name" =>"0 - 1000 Rs"},
                  {"id" =>2,"name" =>"1000 Rs - 2000 Rs"},
                  {"id" =>3,"name" =>"2000 Rs - 6000 Rs"},
                  {"id" =>4,"name" =>"More Than 6000"}]
  	
  end
  def productfilter_listing

      
       params[:filter_checkbox].each do |key, value|
        puts "#{key} ........ #{value}"
       end
      @query=""
      @sort_by = ''
      @qur_aa = []
    if params[:filter_checkbox].present?
      params[:filter_checkbox].each do |key, value|
        if key=="subcategory_id" and value!=""
          c_id = Product.where("#{key} in (#{value})").pluck('distinct id')
          if c_id!=""
            c_id.each do | vv |
               puts "#{vv.inspect}"
              @qur_aa.push vv
            end
          end
        elsif key=="sort_id" and value!=""
           if value.to_i == 2
            @sort_by = 'price asc' 
           elsif value.to_i == 3
             @sort_by = 'price desc'
           elsif value.to_i == 4
            @sort_by = 'created_at desc'
           end 
        elsif key=="color_id" and value!=""
          c_id = ProductColor.where("#{key} in(#{value})").pluck('distinct product_id')
          if c_id!=""
            c_id.each do | vv |
               puts "#{vv.inspect}"
              @qur_aa.push vv
            end
            puts "#{@qur_aa.inspect}"
          end
        elsif key=="brand_id" and value!=""
          c_id = ProductBrand.where("#{key} in(#{value})").pluck('distinct product_id')
          if c_id!=""
             c_id.each do | vv |
              @qur_aa.push vv
            end
          end
       
        elsif value!=""
          @query+=" and #{key} in(#{value})"
        end
      end
      if params[:sub_cat_id].present?
        @query1 ="subcategory_id = #{params[:sub_cat_id].strip}"
      end
      @qur_aa1 = []
     
      if @qur_aa.length > 0 
         if @sort_by.present?
           @subcat_products = Product.where(id: @qur_aa.uniq).where("#{@query1}").order("#{@sort_by}").paginate :page=>params[:page], :per_page => 10
         else
          @subcat_products = Product.where(id: @qur_aa.uniq).where("#{@query1}").paginate :page=>params[:page], :per_page => 10
         end
            
      else
        if @sort_by.present?
          @subcat_products = Product.where("#{@query1}").order("#{@sort_by}").paginate :page=>params[:page], :per_page => 10
        else
          @subcat_products = Product.where("#{@query1}").paginate :page=>params[:page], :per_page => 10
        end
        
      end
    end
    respond_to do |format|
      format.js
    end
  end

  # def product_update
     
  #     Product.update_all(:subcategory_id => 1)
  #     render :json => {:success => 'success'}.to_json
  # end

  def product_detail

    pid = params[:p_id]
    @product = Product.where(:id=>pid).first

  end
  def product_search

       if params[:search].present?
         @ser_text = params[:search]
         @subcat_products = Product.where("name like '%#{params[:search].strip}%' or description like '%#{params[:search].strip}%'").paginate(page: params[:page], per_page: 10)
         @pro_count = @subcat_products.count 
         @filter_cats = Subcategory.order("id asc").all
         @filter_brand = Brand.order("id asc").limit(6)
         @filter_color = Color.order("id asc").limit(6)
         @filter_sort = [
                    {"id" =>1,"name" =>"Popular item"},
                    {"id" =>2,"name" =>"Price: Low - High"},
                    {"id" =>3,"name" =>"Price: High - Low"},
                    {"id" =>4,"name" =>"Latest item"}]
         @filter_price = [
                    {"id" =>1,"name" =>"0 - 1000 Rs"},
                    {"id" =>2,"name" =>"1000 Rs - 2000 Rs"},
                    {"id" =>3,"name" =>"2000 Rs - 6000 Rs"},
                    {"id" =>4,"name" =>"More Than 6000"}]
       else
         @subcat_products = Product.all.paginate(page: params[:page], per_page: 10)
       end

  end

  def checkbox_filter
    # @products = Product.joins(:categories).where(categories: { id: params[:cat_id] })
    # respond_to do |format|
    #   format.js
    # end


  end

  def filter_listing

      
       params[:filter_checkbox].each do |key, value|
        puts "#{key} ........ #{value}"
       end
      @query=""
      @sort_by = ''
      @qur_aa = []
    if params[:filter_checkbox].present?
      params[:filter_checkbox].each do |key, value|
        if key=="subcategory_id" and value!=""
          c_id = Product.where("#{key} in (#{value})").pluck('distinct id')
          if c_id!=""
            c_id.each do | vv |
               puts "#{vv.inspect}"
              @qur_aa.push vv
            end
          end
        elsif key=="sort_id" and value!=""
           if value.to_i == 2
            @sort_by = 'price asc' 
           elsif value.to_i == 3
             @sort_by = 'price desc'
           elsif value.to_i == 4
            @sort_by = 'created_at desc'
           end 
        elsif key=="color_id" and value!=""
          c_id = ProductColor.where("#{key} in(#{value})").pluck('distinct product_id')
          if c_id!=""
            c_id.each do | vv |
               puts "#{vv.inspect}"
              @qur_aa.push vv
            end
            puts "#{@qur_aa.inspect}"
          end
        elsif key=="brand_id" and value!=""
          c_id = ProductBrand.where("#{key} in(#{value})").pluck('distinct product_id')
          if c_id!=""
             c_id.each do | vv |
              @qur_aa.push vv
            end
          end
       
        elsif value!=""
          @query+=" and #{key} in(#{value})"
        end
      end
      if params[:search].present?
        @query1 ="name like '%#{params[:search].strip}%' or description like '%#{params[:search].strip}%'"
      end
      @qur_aa1 = []
     
      if @qur_aa.length > 0 
         if @sort_by.present?
           @subcat_products = Product.where(id: @qur_aa.uniq).where("#{@query1}").order("#{@sort_by}").paginate :page=>params[:page], :per_page => 10
         else
          @subcat_products = Product.where(id: @qur_aa.uniq).where("#{@query1}").paginate :page=>params[:page], :per_page => 10
         end
            
      else
        if @sort_by.present?
          @subcat_products = Product.where("#{@query1}").order("#{@sort_by}").paginate :page=>params[:page], :per_page => 10
        else
          @subcat_products = Product.where("#{@query1}").paginate :page=>params[:page], :per_page => 10
        end
        
      end
    end
    respond_to do |format|
      format.js
    end
  end

  

end
